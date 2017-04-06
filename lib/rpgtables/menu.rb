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
        create_table_menu
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
      when 3
        @@menu_state = EXIT
        return
      else
        puts INPUTERROR
      end
    end
  end

  def create_table_menu
    @table = RTable.new
    until @stdin == (10..11)
      puts CREATETABLEMENU
      print INPUTPROMPT
      @stdin = get_value
      case @stdin.to_i
      when 1
        add_dice

      when 2
        add_entry

      when 3
        view_table

      when 4
        roll_table

      when 5
        remove_entry_from_table

      when 6

      when 7

      when 8

      when 9

      when 10

      when 11

      when 12
        @@menu_state = EXIT
        return
      else
        puts INPUTERROR
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

        puts INSERTENTRYPOSPROMPT
        pos = get_value.to_i

        pos = process_table_index_input(pos)


        puts POPENTRYPROMPT
        entry = get_value
        puts "#{pos} | #{entry}"
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

  def view_table
    @table.calculate_table
    i = 0
    puts "----------------------------------------------------------"
    puts " Pos |   %   |                 Entry"
    @table.table.each do |d|
      d.each do |e|
        puts "----------------------------------------------------------"
        if e == nil
          e = "Empty"
        end
        puts "#{i + @table.dice.count}".ljust(6) +
        "#{'%.2f' % @table.percent_array[i]}%".ljust(7) + "#{e}".ljust(20)
        i += 1
      end
    end
    puts CONTINUE
    gets
  end

  def roll_table
    entry = @table.roll_table
    roll = @table.get_last_roll
    puts "----------------------------------------------------------"
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
      puts "Please input the entry number of the item you wish to remove: "
      @stdin = get_value.to_i
      @stdin = process_table_index_input(@stdin)
      @table.remove_entry(@stdin)
    else
      puts INPUTERROR
      gets
    end
  end

  private

    def process_table_index_input(pos)
      # input must be within the roll range of the dice
      until pos >= @table.dice.count && pos <= (@table.get_table_size + @table.dice.count - 1)
        puts "Please enter a valid entry number #{@table.dice.count} - #{@table.get_table_size + @table.dice.count - 1}."
        gets
        puts INSERTENTRYPOSPROMPT
        pos = get_value.to_i
      end

      return pos
    end

end
