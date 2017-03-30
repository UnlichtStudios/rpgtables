$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'rpgtables'
require 'rpgtables/rtable'

require 'minitest/autorun'
require 'minitest/reporters'
Minitest::Reporters.use!

def seed_table
  @rtable.add_dice([6, 12, 6])
  letters = ('a'..'z').to_a
  22.times.each do |x|
    @rtable.add_entry(letters.shift)
  end
end
