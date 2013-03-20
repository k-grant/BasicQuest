require 'minitest/autorun'
require 'stringio'
require '../Game.rb'



class GameTest < MiniTest::Unit::TestCase
  def setup
    @command_list = ["north", "east", "west", 
                  "south", "s", "e", "w",
                  "n", "North", "East", "South", "North"]
    @input  = StringIO.new
    @game   = Game.new("sampleLevel.xml")
    @invalid_command_list = ["up", "down", "nor", "3", "do it",
                      "ding dong", "left", "right", "go down"]
    
  end


   # This method will run the game untill it is completed. The assert being true shows the game has ended successfully
   # This is a good way of testing almost every single method in the program.
  def test_game
      @game.testLoop(@command_list)
      assert(@game.world.user.userWon)
   end
   
   

  def provide_input(string)
      remember = @input.pos
      STDIN << string
      #@input.pos = remember
  end
end