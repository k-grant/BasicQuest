require 'minitest/autorun'
require 'stringio'
require '../game.rb'

 class GameTest < MiniTest::Unit::TestCase
  def setup
    @command_list = ["north", "east", "west",
                  "south", "s", "e", "w",
                  "n", "North", "East", "South", "North"]
    @game   = Game.new("sampleLevel.xml")
  end

  # This method will run the game until it is completed. The assert being true shows the game has ended successfully
  # This is a good way of testing almost every single method in the program.
  def test_game
    @game.command_list = @command_list
    @game.loop
    assert(@game.world.user.userWon)
  end
end
