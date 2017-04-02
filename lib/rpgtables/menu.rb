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
    @table = RTable.new
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

    until @stdin == (10..11)
      puts CREATETABLEMENU
      print INPUTPROMPT
      @stdin = get_value
      puts @stdin.to_s
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

      when 11
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
    if dice == 1
      @table.add_dice(dice[0])
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
    puts "COUNT #{@table.get_entry_count} SIZE #{@table.get_table_size}"
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

  def view_table
    i = 1
    puts "----------------------------------------------------------"
    puts " Pos | % |                 Entry"
    @table.table.each do |d|
      d.each do |e|
        puts "----------------------------------------------------------"
        puts " #{i} " + "         #{e}"
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
    puts "Please enter the "
  end

end
