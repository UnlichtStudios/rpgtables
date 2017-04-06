# RTable.rb
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

# A table containing entries that can be randomly chosen
class RTable

  attr_accessor :table, :dice

  attr_reader :percent_array

  def initialize
    @table = []
    @rolls = []
    @dice = []
    @percent_array = []
  end

  def add_die(die)
    if @table.count == 0
      @table.push(Array.new(die))
      @dice.push(die)
    else
      @table.push(Array.new(die - 1))
      @dice.push(die)
    end
  end

  def add_dice(dice)
    dice.each do |d|
      if @table.count == 0
        @table.push(Array.new(d))
        @dice.push(d)
      else
        @table.push(Array.new(d - 1))
        @dice.push(d)
      end
    end
  end

  def remove_die(*args)
    if args.count == 0
      @table.pop
      @dice.pop
    elsif args.count == 1
      @table.delete_at(args[0] - 1)
      @dice.delete_at(args[0] - 1)
    else
      raise ArgumentError.new("Wrong number of arguments. Expecting 0 or 1, but got #{args.count}.")
    end
  end

  def add_entry(entry)
    available_entry = get_available_entry
    @table[available_entry[0]].insert(available_entry[1], entry)
    @table[available_entry[0]].delete_at(available_entry[1] + 1)
  end

  def insert_entry(index, entry)
    i = get_entry(index - @dice.count)
    @table[i[0]].insert(i[1], entry)
    @table[i[0]].delete_at(i[1] + 1)
  end

  def remove_entry(*args)
    if args.count == 0
      i = get_available_entry
      if i == nil
        @table.last.pop
        @table.last.push(nil)
      else
        @table[i[0]].delete_at(i[1] - 1)
        @table[i[0]].insert(i[1], nil)
      end
    elsif args.count == 1
      i = get_entry(args[0] - @dice.count)
      @table[i[0]].insert(i[1], nil)
      @table[i[0]].delete_at(i[1] + 1)
    else
      raise ArgumentError.new("Wrong number of arguments. Expecting 0 or 1, but got #{args.count}.")
    end
  end

  def roll_table
    sum = 0
    @dice.each do |d|
      r = rand(d.to_i + 1)
      sum += r
      @rolls.push(r)
    end
    i = get_entry(sum)
    return @table[i[0]][i[1]]
  end

  def reset_table
    @table.each do |d|
      d.map! { |x| x = nil}
    end
  end

  def destroy_die_entries(die)
    die -= 1
    @table[die].map! { |x| x = nil }
  end

  def destroy_table
    @table = []
    @dice = []
  end

  def get_table_size
    num = 0
    @table.each do |x|
      num += x.count
    end
    return num
  end

  def get_last_roll
    sum = 0
    @rolls.each do |r|
      sum += r
      return sum
    end
  end

  def get_entry_count
    i = 0
    @table.each do |d|
      d.each do |e|
        if e == nil
          return i
        end
        i += 1
      end
    end
    return i
  end

  def calculate_table
    @table_index_array = get_table_index_array
    @expand_dice_set = get_expanded_dice_set
    @total_dice_combinations = get_dice_combinations
    @percent_array = []

    @counts = 0
    match_array = []
    @table_index_array.each do |x|
      @counts = 0
      match_array.push(get_match_count(x))
    end
    match_array.each do |x|
      @percent_array.push((x / @total_dice_combinations) * 100)
    end
  end

  private

    def get_available_entry
      @table.each do |d|
        d.each do |e|
          if e == nil
            return [@table.index(d), @table[@table.index(d)].index(e)]
          end
        end
      end
      return nil
    end

    def get_entry(index)
      i = 0
      @table.each do |d|
        d.each_index do |e|
          if i == index
            return [@table.index(d), e]
          end
          i += 1
        end
      end
      return nil
    end

    def get_table_index_array
      table_array = []
      table_size = get_table_size
      table_size.times.each do |x|
        table_array.push(x + @dice.count)
      end
      return table_array
    end

    def get_expanded_dice_set
      expand_set = []
      @dice.each do |d|
        tmp_ary = []
        d.times.each do |x|
          tmp_ary.push(x + 1)
        end
        expand_set.push(tmp_ary)
      end
      return expand_set
    end

    def get_dice_combinations
      rolls = 1.0
      @dice.each do |x|
        rolls *= x
      end
      return rolls
    end

    def get_match_count(roll)
      first_die = @expand_dice_set.values_at(0).flatten
      *rest_of_dice = @expand_dice_set.values_at(1..-1)
      matching_combinations = first_die.product(*rest_of_dice)

      return @counts = matching_combinations.
                select{ |c| c.inject(:+) == roll }.
                to_a.count
    end
end
