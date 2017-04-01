$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'rpgtables'
require 'rpgtables/rtable'
require 'rpgtables/menu'
require 'rpgtables/menustate'

require 'minitest/autorun'
require 'minitest/mock'
require 'minitest/reporters'
Minitest::Reporters.use!

def seed_table
  @rtable.add_dice([6, 12, 6])
  letters = ('a'..'z').to_a
  22.times.each do
    @rtable.add_entry(letters.shift)
  end
end
