require 'minitest/autorun'
require '../world.rb'

class WorldTest < MiniTest::Unit::TestCase
  def setup
    
    @world = World.new("sampleLevel.xml")
    @testWorld = @world.rooms
  end

  # Make sure the random room assigned to user/grue is an actual room
  def test_initialize
    assert(@world.rooms.has_key?(@world.user.currentRoom.title))
    assert(@world.rooms.has_key?(@world.grue.grueCurrentRoom.title))
  end



end