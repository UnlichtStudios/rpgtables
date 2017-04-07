# menu.rb
#
# Copyright 2017 (c) Scott Isenberg
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require_relative 'menuprompts'
require_relative 'menustate'
require_relative 'rtable'
include MenuPrompts
include MenuState

#Main Menu
class Menu

  attr_reader :table
  attr_writer :stdin

  def initialize
    @stdin = ""
    @loaded_table = RTable.new
  end

  def menu_state
    return @@menu_state
  end

  def get_value
    gets.chomp
  end

  def process_menu
    @@menu_state = MAIN
    until @@menu_state == EXIT
      case @@menu_state
      when MAIN
        main_menu
      when CREATE
        table_menu("Create")
      when VIEW
        view_tables_menu
      when EDIT
        table_menu("Edit")
      end
    end
  end

  def main_menu
    @@menu_state = MAIN
    puts MAINMENU
    until @stdin == (1..3)
      print INPUTPROMPT
      @stdin = get_value
      case @stdin.to_i
      when 1
        @@menu_state = CREATE
        return
      when 2
        @@menu_state = VIEW
        return
      when 3
        @@menu_state = EXIT
        return
      else
        puts INPUTERROR
      end
    end
  end

  def table_menu(name)
    if name == "Create"
      @table = RTable.new
      puts TABLENAMEPROMPT
      @stdin = get_value.split("").reject{|i| i == "/" || i == "\\0"}.join
      @table.set_name(@stdin)
    else
      @table = @loaded_table
    end

    until @stdin == (10..11)
      display_menu(name)
      print INPUTPROMPT
      @stdin = get_value
      case @stdin.to_i
      when 1
        add_dice

      when 2
        add_entry

      when 3
        view_table(@table)

      when 4
        roll_table(@table)

      when 5
        remove_entry_from_table

      when 6
        remove_entries_from_die

      when 7
        remove_die_from_table

      when 8
        remove_all_entries_from_table

      when 9
        clear_table

      when 10
        save_table

      when 11
        @@menu_state = MAIN
        return

      when 12
        @@menu_state = EXIT
        return
      else
        puts INPUTERROR
      end
    end
  end

  def view_tables_menu
    @tablenames = []
    until @stdin == (1..6)
      puts VIEWTABLE
      puts VIEWTABLEMENU
      puts INPUTPROMPT
      @stdin = get_value.to_i
      case @stdin
      when 1
        display_tables

        puts VIEWTABLEPROMPT
        load_table
        view_table(@loaded_table)

      when 2
        display_tables

        puts EDITTABLEPROMPT
        load_table
        @@menu_state = EDIT
        return

      when 3
        display_tables

        puts DESTROYTABLEPROMPT
        @stdin = process_input(0, @tablenames.count)

        name = @tablenames[@stdin - 1].split(" ").
                                       reject{|i| i == "/" || i == "\\0"}.
                                       join
        delete_table(name)

      when 4
        display_tables
        puts ROLLTABLEPROMPT

        load_table
        roll_table(@loaded_table)

      when 5
        @@menu_state = MAIN
        return
      when 6
        @@menu_state = EXIT
        return
      end

    end

  end

  def add_dice
    dice = []

    print ADDDICEPROMPT

    @stdin = get_value
    dice = @stdin.split(/[^\d]/).map { |i| i.to_i }.reject { |i| i == 0}

    if dice.count == 1
      @table.add_die(dice[0])
    else
      @table.add_dice(dice)
    end
    dice.each do |d|
      puts "d#{d} added to table!"
    end

    print CONTINUE
    gets
  end

  def add_entry
    if @table.table.count > 0 && @table.get_entry_count < @table.get_table_size
      print ADDENTRYPROMPT

      @stdin = get_value
      if @stdin.to_i == 1
        puts POPENTRYPROMPT

        @stdin = get_value
        @table.add_entry(@stdin)

        puts "'#{@stdin}' added to table!"
        gets
      elsif @stdin.to_i == 2
        pos = 0
        entry = ""

        pos = process_input(@table.dice.count, @table.get_table_size + @table.dice.count - 1, INSERTENTRYPOSPROMPT)

        puts POPENTRYPROMPT

        entry = get_value
        @table.insert_entry(pos, entry)

        puts "'#{entry}' added to table at position #{pos}!"
        gets
      else
        puts PROMPTERROR
        gets
      end
    else
      puts TABLEERROR
      gets
    end
  end

  def view_table(table)
    table.calculate_table
    i = 0
    "----------------------------------------------------------"

    puts table.name.center(58)

    puts "----------------------------------------------------------"
    puts " Pos |   %   |                 Entry"
    table.table.each do |d|
      d.each do |e|
        puts "----------------------------------------------------------"
        if e == nil
          e = "Empty"
        end
        puts "#{i + table.dice.count}".ljust(6) +
        "#{'%.2f' % table.percent_array[i]}%".ljust(7) + "#{e}".ljust(20)
        i += 1
      end
    end
    puts CONTINUE
    gets
  end

  def roll_table(table)
    entry = table.roll_table
    roll = table.get_last_roll

    puts "----------------------------------------------------------"
    if entry == nil
      entry = "Empty"
    end

    puts "You rolled a #{roll + 1}. Your result is #{entry}."
    print CONTINUE
    gets
  end

  def remove_entry_from_table
    puts REMOVEENTRYPROMPT

    @stdin = get_value.to_i
    if @stdin == 1
      @table.remove_entry
    elsif @stdin == 2

      @stdin = process_input(@table.dice.count, @table.get_table_size + @table.dice.count - 1, ENTRYREMOVALPROMPT)
      @table.remove_entry(@stdin)
    else
      puts INPUTERROR
      gets
    end
  end

  def remove_entries_from_die
    puts REMOVEDIEENTRIESPROMPT
    display_dice

    @stdin = process_input(0, @table.dice.count)
    @table.destroy_die_entries(@stdin)
  end

  def remove_die_from_table
    puts REMOVEDIEPROMPT

    @stdin = get_value.to_i
    if @stdin == 1
      @table.remove_die
    elsif @stdin == 2
      display_dice
      @stdin = process_input(0, @table.dice.count, SELECTDIETOREMOVEPROMPT)
      @table.remove_die(@stdin)
    else
      puts INPUTERROR
      gets
    end

  end

  def remove_all_entries_from_table
    @stdin = process_input(0, 2, RESETTABLEPROMPT)
    if @stdin == 1
      @table.reset_table
    else
      return
    end
  end

  def clear_table
    puts CLEARTABLEPROMPT
    @stdin = process_input(0, 2, CLEARTABLEPROMPT)
    if @stdin == 1
      @table.destroy_table
    else
      return
    end
  end

  def save_table
    puts SAVETABLEPROMPT
    name = @table.name.
      split(" ").
      reject{|i| i == "/" || i == "\\0"}.
      join
    @table.save_table(name)
    puts "Table saved as data/#{name}_rpgtable.json"
    gets
  end

  def display_tables
    puts "|------------------------------------------------------|"
    puts "|                                                      |"
    i = 1
    Dir.glob('data/*_rpgtable.json') do |f|
      table_name = get_table_name(f.to_s)
      @tablenames.push(table_name)
      puts "|" + "#{i}) #{table_name}".center(54) + "|"
      i += 1
    end
    puts "|                                                      |"
    puts "|------------------------------------------------------|"
  end

  private

    def process_input(first, second, prompt=nil)
      print prompt
      input = get_value.to_i
      # input must be within the roll range of the dice
      until input >= first && input <= second
        puts "Please enter a valid entry number #{first} - #{second}."
        gets
        puts prompt
        input = get_value.to_i
      end

      return input
    end

    def display_dice
      puts "----------------------------------------------------------"
      i = 1
      @table.dice.each do |d|
        puts "#{i}) d#{d}"
        i += 1
      end
    end

    def get_table_name(file)
      json = File.read(file)
      obj = JSON.parse(json)
      return obj["name"]
    end

    def load_table
      @stdin = process_input(0, @tablenames.count)

      @loaded_table.load_table(@tablenames[@stdin - 1].
                    split(" ").
                    reject{|i| i == "/" || i == "\\0"}.
                    join)
    end

    def delete_table(name)
      File.delete("data/#{name}_rpgtable.json") if File.exist?("data/#{name}_rpgtable.json")
    end

end
