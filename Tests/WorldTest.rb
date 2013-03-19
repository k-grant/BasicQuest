require 'minitest/autorun'
require '../World.rb'

class WorldTest < MiniTest::Unit::TestCase
  def setup
    
    @world = World.new("sampleLevel.xml")
    @testWorld = @world.rooms
  end

  # Make sure the random room assigned to user is an actual room
  def test_initialize
    assert(@world.rooms.has_key?(@world.user.currentRoom.title))
  end

  # This test method will make sure valid paths return true and invalid paths return false
  # The tests are run for every direction and are ran as many times as there are rooms in order
  # to transverse most of the map
  def test_move_user_around
    @testWorld.length.times do

      if(@world.user.currentRoom.north!="0")
        assert_equal @world.user.userMove("North"), true
      else
        assert_equal @world.user.userMove("North"), false
      end

      if(@world.user.currentRoom.south!="0")
        assert_equal @world.user.userMove("South"), true
      else
        assert_equal @world.user.userMove("South"), false
      end

      if(@world.user.currentRoom.east!="0")
        assert_equal @world.user.userMove("East"), true
      else
        assert_equal @world.user.userMove("East"), false
      end

      if(@world.user.currentRoom.west!="0")
        assert_equal @world.user.userMove("West"), true
      else
        assert_equal @world.user.userMove("West"), false
      end

    end

  end

end