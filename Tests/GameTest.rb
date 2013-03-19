require 'minitest/autorun'
require 'stringio'
require '../Game.rb'
require '../World.rb'
require '../User.rb'


class GameTest < MiniTest::Unit::TestCase
  def setup
    @command_list = ["north", "east", "west", 
                  "south", "s", "e", "w",
                  "n", "North", "East", "South", "North"]
    @input  = StringIO.new
    @game   = Game.new(@input,"sampleLevel.xml","Kevin")
    @invalid_command_list = ["up", "down", "nor", "3", "do it",
                      "ding dong", "left", "right", "go down"]
  end

  def test_equal_valid_commands
   @command_list.each do|n|
    provide_input(n);
    @game.get_command
      assert_equal n, @game.command
    end
   end
   
  def test_equal_invalid_commands
   @invalid_command_list.each do|n|
    provide_input(n);
    @game.get_command
      assert_equal nil, @game.command
    end
   end
   
   

  def provide_input(string)
      remember = @input.pos
      @input << string
      @input.pos = remember
  end
end