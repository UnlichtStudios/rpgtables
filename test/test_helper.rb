$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'rpgtables'
require 'rpgtables/rtable'

require 'minitest/autorun'
require 'minitest/reporters'
Minitest::Reporters.use!
