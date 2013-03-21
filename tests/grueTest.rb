require 'minitest/autorun'
require 'stringio'
require '../world.rb'

class GrueTest < MiniTest::Unit::TestCase
  def setup
    @world = World.new("sampleLevel.xml")
  end

  # Makes sure the grue movement works as it should
  def test_move
    room = @world.grue.current_room.clone()
    nextMove = @world.grue.nextMove
    @world.grue.grue_move(@world.grue.nextMove)
    assert_equal @world.grue.current_room.title,room.return_title(nextMove)
  end

  # this method tests grues ability to reach the user on a straight short path.
  def test_move_to_user
    (@world.rooms.length).times do
      @world.assign_user_random_room
      @world.assign_grue_far_room
      (@world.grue.pathFinder.path_weights[@world.grue.current_room.title][@world.user.current_room.title].distance).times do
        @world.grue.move_grue_to_user(@world.user.current_room)
      end
      assert_equal @world.grue.current_room.title,@world.user.current_room.title
    end
  end

  # Tests to make sure grue is not in same room after being attacked
  def test_grue_attacked
    room = @world.grue.current_room.clone()
    @world.grue.grue_attacked
    assert_equal room!=@world.grue.current_room,true
  end

end
