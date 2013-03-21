require 'minitest/autorun'
require '../world.rb'

class WorldTest < MiniTest::Unit::TestCase
  
  def setup
    @world = World.new("sampleLevel.xml")
    @testWorld = @world.rooms
  end

  # Make sure the random room assigned to user/grue is an actual room
  def test_initialize
    assert(@world.rooms.has_key?(@world.user.current_room.title))
    assert(@world.rooms.has_key?(@world.grue.current_room.title))
  end

end
