$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require "rpgtables/version.rb"
require "rpgtables/rtable.rb"
require "rpgtables/menu"

module Rpgtables
  @menu = Menu.new

  #@menu.process_menu
end
