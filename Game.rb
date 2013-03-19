
require_relative 'World.rb'
class Game
  attr_reader :command

  def initialize(readin=STDIN, output=STDOUT, xmlFilePath,userName)
    @input = readin
    @output = output
    # valid commands
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
    # loop runs as long as user hasnt won or quit yet
    while (@command != "quit" && !@world.user.userWon)
      puts "You are in room: "+ @world.user.currentRoom.title
      # every 4 turns take a rest and move grue
      if(turns%4==0 && turns!=0)
        puts " "
        puts "~~~~Resting~~~~"
        puts " "
        turns =0
        if(@world.grue.returnDistanceToUser==1)
            puts "You hear a loud growl from one of the adjacent rooms!"
       end
        
        @world.grue.grueMove(@world.grue.nextMove.to_s())
       if(@world.grue.grueCurrentRoom.title == @world.user.currentRoom.title)
         @world.user.userAttacked
       end
         
      else
        
        @world.updateGrueNextMove
       if(@world.grue.returnDistanceToUser==1)
            puts "You hear a loud growl from one of the adjacent rooms!"
       end
      # => gets user input
      get_command
      
      # userMove returns boolean which shows if a valid path was taken
      if(@world.user.userMove(@command))
        turns = turns + 1
        #handle attacks
       if(@world.grue.grueCurrentRoom.title == @world.user.currentRoom.title)
         @world.grue.grueAttacked
         @world.user.pickUpCrystal
         puts "You now have #{@world.user.crystals} crystals!"
       end
       
      end
      end
      
    end
    
    if(@world.user.userWon)
      puts "Congratulations you win!!"
    end
  end
end

game = Game.new("sampleLevel.xml","Kevin")
game.loop
