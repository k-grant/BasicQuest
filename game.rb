require_relative 'world.rb'

class Game

  attr_accessor :world,:input,:command,:command_list
  def initialize(readin=STDIN, output=STDOUT, xmlFilePath)
    @input = readin
    @output = output
    @world = World.new(xmlFilePath)
    @command_list = []
  end

  def get_command
    if(@command_list.length==0)
      temp_command = @input.gets
      temp_command.chomp!
      @command = temp_command
    else
      @command = @command_list.sample
    end
  end

  def user_turn

    @world.grue.determine_next_move(@world.user.currentRoom)
    @world.grue.grue_close_check

    get_command

    while(!@world.user.user_move(@command))
      get_command
    end
    if(@world.grue.grueCurrentRoom.title == @world.user.currentRoom.title)
      @world.grue.grueAttacked
      @world.user.pick_up_crystal
    end
  end

  def grue_turn
    @world.grue.grue_close_check
    @world.grue.move_grue_to_user(@world.user.currentRoom)
    if(@world.grue.grueCurrentRoom.title == @world.user.currentRoom.title)
      @world.user.user_attacked
    end
  end

  def resting_turn
    puts " "
    puts "~~~~Resting~~~~"
    puts " "
  end

  def loop
    turns = 0
    # Game loop runs as long as user hasnt won or quit yet.
    while (@command != "quit" && !@world.user.userWon)
      # Every 4 turns take a rest and move grue.
      if(turns%4==0 && turns!=0)
        resting_turn
        turns =0
        grue_turn
      else
        user_turn
      turns= turns+1
      end
    end

    if(@world.user.userWon)
      puts "Congratulations you win!!"
    end
  end

end

