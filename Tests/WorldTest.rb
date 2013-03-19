require 'minitest/autorun'
require '../World.rb'



class WorldTest < MiniTest::Unit::TestCase
  def setup
    @user = User.new("Kevin")
    @world = World.new("sampleLevel.xml",@user)
    @userLocation = @user.currentRoom
  end
  
  
  # Make sure the random room assigned to user is an actual room
  def test_initialize
     assert(@world.rooms.has_key?(@user.currentRoom.title))
  end
  
  
   
end