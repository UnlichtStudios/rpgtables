# rtable_test.rb
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

require 'test_helper'

class RTableTest < Minitest::Test

  def setup
    @rtable = RTable.new
    @othertable = RTable.new
  end

  def test_that_it_has_a_table
    refute_nil @rtable.table
  end

  def test_add_die
    @rtable.add_die(6)
    assert_equal 1, @rtable.table.count
    assert_equal 6, @rtable.table[0].count
    assert_equal 1, @rtable.dice.count
    @rtable.add_die(12)
    assert_equal 2, @rtable.table.count
    assert_equal 2, @rtable.dice.count
    assert_equal 17, @rtable.get_table_size
  end

  def test_add_dice
    @rtable.add_dice ([6, 12, 20, 6])
    assert_equal 4, @rtable.table.count
    assert_equal 4, @rtable.dice.count
    assert_equal 41, @rtable.get_table_size
  end

  def test_remove_die
    @rtable.add_dice ([6, 12, 20, 6, 12])
    @rtable.remove_die
    assert_equal 4, @rtable.table.count
    assert_equal 41, @rtable.get_table_size
    @rtable.remove_die(3)
    assert_equal 3, @rtable.table.count
    assert_equal 22, @rtable.get_table_size
  end

  def test_remove_die_argument_error
    err = assert_raises(ArgumentError) {@rtable.remove_die(3, 4)}
    assert_match /Wrong number of arguments. Expecting 0 or 1, but got 2/,
                  err.message
  end

  def test_add_entry
    @rtable.add_dice([6, 12, 20, 6])
    @rtable.add_entry("a")
    assert_equal "a", @rtable.table[0][0]
    @rtable.add_entry("b")
    @rtable.add_entry("c")
    @rtable.add_entry("d")
    @rtable.add_entry("e")
    @rtable.add_entry("f")
    @rtable.add_entry("g")
    assert_equal "g", @rtable.table[1][0]
  end

  def test_insert_entry
    seed_table
    @rtable.insert_entry(8, "INSERT")
    assert_equal "INSERT", @rtable.table[1][1]
  end

  def test_remove_entry
    seed_table
    @rtable.remove_entry
    assert_equal nil, @rtable.table.last.last
    @rtable.remove_entry(14)
    assert_equal nil, @rtable.table[1][7]
  end

  def test_roll_table
    seed_table
    assert_match /[a-z]/, @rtable.roll_table
  end

  def test_reset_table
    seed_table
    @rtable.reset_table
    @othertable.add_dice([6, 12, 6])
    assert_equal @othertable.table, @rtable.table
  end

  def test_destroy_table
    seed_table
    @rtable.destroy_table
    assert_equal [], @rtable.table
  end

  def test_get_entry_count
    seed_table
    5.times.each do
      @rtable.remove_entry
    end
    assert_equal 17, @rtable.get_entry_count
  end

end
