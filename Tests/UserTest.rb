require 'minitest/autorun'
require 'stringio'
require '../World.rb'


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
end