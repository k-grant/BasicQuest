require 'minitest/autorun'
require 'stringio'
require '../World.rb'


class GrueTest < MiniTest::Unit::TestCase
  def setup
    @world = World.new("sampleLevel.xml")  
  end
  
  
  # Makes sure the grue movement works as it should
  def test_move
    room = @world.grue.grueCurrentRoom.clone()
    nextMove = @world.grue.nextMove
    @world.grue.grueMove(@world.grue.nextMove)
    assert_equal @world.grue.grueCurrentRoom.title,room.returnTitle(nextMove)
  end
  
  
  # this method tests grues ability to reach the user on a straight short path.
 def test_move_to_user
    (@world.rooms.length).times do
      @world.assignUserRandomRoom
      @world.assignGrueToFarRoom
      (@world.grue.pathFinder.pathWeights[@world.grue.grueCurrentRoom.title][@world.user.currentRoom.title].distance).times do
        @world.grue.grueMove(@world.grue.nextMove)
      end
      assert_equal @world.grue.grueCurrentRoom.title,@world.user.currentRoom.title
    end
  end
  
  # Tests to make sure grue is not in same room after being attacked
  def test_grue_attacked
    room = @world.grue.grueCurrentRoom.clone()
    @world.grue.grueAttacked
    assert_equal (room!=@world.grue.grueCurrentRoom),true
  end


end