require 'minitest/autorun'
require 'stringio'
require '../world.rb'

class UserTest < MiniTest::Unit::TestCase
  def setup
    @world = World.new("sampleLevel.xml")
  end

  def test_initialize

    assert_equal @world.user.crystals,0

  end

  def test_crystalPickUp
    @world.user.pickUpCrystal
    assert_equal @world.user.crystals,1
    @world.user.pickUpCrystal
    assert_equal @world.user.crystals,2
    @world.user.userAttacked
  end

  def test_crystalDrop
    @world.user.pickUpCrystal
    @world.user.userAttacked
    assert_equal @world.user.crystals,0
  end

  def test_pick_up_attacked
    @world.user.pickUpCrystal
    assert_equal @world.user.crystals,1
    @world.user.pickUpCrystal
    assert_equal @world.user.crystals,2
    @world.user.pickUpCrystal
    assert_equal @world.user.crystals,3
    @world.user.pickUpCrystal
    assert_equal @world.user.crystals,4
    @world.user.userAttacked
    assert_equal @world.user.crystals,0
    @world.user.userAttacked
    assert_equal @world.user.crystals,0
  end

  # This test method will make sure valid paths return true and invalid paths return false
  # The tests are run for every direction and are ran as many times as there are rooms in order
  # to transverse most of the map
  def test_move_user_around
    @world.rooms.length.times do

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
