
require_relative 'World.rb'
class Game
  attr_reader :command

  def initialize(readin=STDIN, output=STDOUT, xmlFilePath,userName)
    @input = readin
    @output = output
    @command_list = ["north", "east", "west", 
                  "south", "s", "e", "w",
                  "n", "North", "East", "South", "North", "quit"]
    
    @user = User.new(userName)  
    @world = World.new(xmlFilePath,@user)            
                  
  end

  def get_command
    temp_command = @input.gets
    temp_command.chomp!
     @command = temp_command
  end

  def loop
    while @command != "quit"
       puts "You are in room: "+ @world.user.currentRoom.title
      get_command
      @world.userMove(@command)
     
    end
  end
end

#game = Game.new("sampleLevel.xml","Kevin")
#game.loop
