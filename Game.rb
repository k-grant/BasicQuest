
require_relative 'World.rb'
class Game
  attr_reader :command

  def initialize(readin=STDIN, output=STDOUT, xmlFilePath,userName)
    @input = readin
    @output = output
    @command_list = ["north", "east", "west", 
                  "south", "s", "e", "w",
                  "n", "North", "East", "South", "North", "quit"]
    
    
    @world = World.new(xmlFilePath)            
                  
  end

  def get_command
    temp_command = @input.gets
    temp_command.chomp!
     @command = temp_command
  end

  def loop
    turns = 0
    while @command != "quit"
      
      if(turns%4==0 && turns!=0)
        
        puts "Resting"
        @world.grue.grueMove(@world.grue.nextMove.to_s())
       puts "Grue is at #{@world.grue.grueCurrentRoom.title}"
       
       if(@world.grue.grueCurrentRoom.title == @world.user.currentRoom.title)
         @world.user.userAttacked
       end
       
       @world.updateGrueNextMove
         turns = turns + 1
      else
        @world.updateGrueNextMove
       puts "You are in room: "+ @world.user.currentRoom.title
       puts "Grue is at #{@world.grue.grueCurrentRoom.title}"

      get_command
      if(@world.user.userMove(@command))
        turns = turns + 1
       if(@world.grue.grueCurrentRoom.title == @world.user.currentRoom.title)
         @world.grue.grueAttacked
       end
      end
      end
      
    end
  end
end

game = Game.new("sampleLevel.xml","Kevin")
game.loop
