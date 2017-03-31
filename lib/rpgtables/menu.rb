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

  attr_writer :stdin

  def initialize
    @stdin = ""
  end

  def menu_state
    return @@menu_state
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
      @stdin = gets.chomp
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
      @stdin = gets.chomp
      case @stdin.to_i
      when 1
        dice = []
        print ADDDICEPROMPT
        @stdin = gets.chomp
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

      when 2
        if @table.table.count > 0
          print ADDENTRYPROMPT
          @stdin = gets.chomp
          if @stdin.to_i == 1
            puts POPENTRYPROMPT
            @stdin = gets.chomp
            @table.add_entry(@stdin)
            puts "'#{@stdin}' added to table!"
            gets
          elsif @stdin.to_i == 2
            pos = 0
            entry = ""
            puts INSERTENTRYPOSPROMPT
            pos = gets.chomp.to_i
            puts POPENTRYPROMPT
            entry = gets.chomp
            @table.insert_entry(pos, entry)
            puts "'#{entry}' added to table at position #{pos}!"
            gets
          else
            puts PROMPTERROR
            gets
          end
        else
          puts TABLEEMPTYERROR
          gets
        end

      when 3
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
        print CONTINUE
        gets

      when 11
        @@menu_state = EXIT
        return
      else
        puts INPUTERROR
      end
    end
  end

end
