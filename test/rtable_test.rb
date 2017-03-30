require 'test_helper'

class RTableTest < Minitest::Test

  def setup
    @rtable = RTable.new
  end

  def test_that_it_has_a_table
    refute_nil @rtable.table
  end

  def test_add_die
    @rtable.add_die(6)
    assert_equal 1, @rtable.table.count
    assert_equal 6, @rtable.table[0].count
    @rtable.add_die(12)
    assert_equal 2, @rtable.table.count
    assert_equal 17, @rtable.get_table_size
  end

  def test_add_dice
    @rtable.add_dice ([6, 12, 20, 6])
    assert_equal 4, @rtable.table.count
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
    puts @rtable.table[1][0]
    assert_equal "g", @rtable.table[1][0]
  end

  def test_insert_entry
    @rtable.add_dice([6, 12, 6])
    @rtable.add_entry("a")
    @rtable.add_entry("b")
    @rtable.add_entry("c")
    @rtable.add_entry("d")
    @rtable.add_entry("e")
    @rtable.add_entry("f")
    @rtable.add_entry("g")
    @rtable.add_entry("h")
    @rtable.add_entry("i")
    @rtable.add_entry("j")
    @rtable.add_entry("k")
    @rtable.insert_entry(8, "INSERT")
    assert_equal "INSERT", @rtable.table[1][2]
  end
end
