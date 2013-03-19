require 'minitest/autorun'
require 'stringio'
require '../User.rb'


class UserTest < MiniTest::Unit::TestCase
  def setup
    @user = User.new("Kevin")
  end

  def test_initialize

      assert_equal @user.crystals,0
    
   end
   
  def test_crystalPickUp
    @user.pickUpCrystal
    assert_equal @user.crystals,1
    @user.pickUpCrystal
    assert_equal @user.crystals,2
    @user=User.new("Kevin")
   end
   
  def test_crystalDrop
     @user.pickUpCrystal
    @user.userAttacked
    assert_equal @user.crystals,0
  end
  
  def test_pick_up_attacked
        @user.pickUpCrystal
    assert_equal @user.crystals,1
    @user.pickUpCrystal
    assert_equal @user.crystals,2
        @user.pickUpCrystal
    assert_equal @user.crystals,3
    @user.pickUpCrystal
    assert_equal @user.crystals,4
    @user.userAttacked
    assert_equal @user.crystals,0
    @user.userAttacked
    assert_equal @user.crystals,0
  end
end