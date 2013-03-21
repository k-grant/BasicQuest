class User

  attr_accessor :crystals,:current_room,:world,:userWon
  # initialize name and number of crystals
  def initialize(world_reference)
    @crystals =0
    @world = world_reference
    @current_room=nil
    @userWon = false
  end

  # Method called by User when he picks up a crystal
  def pick_up_crystal
    @crystals = crystals+1
    if(@crystals==1)
      puts "You now have #{@crystals} crystal!"
    else
      puts "You now have #{@crystals} crystals!"
    end
  end

  # Method called when user is attacked, respawn will be handeled by the world
  def user_attacked
    @crystals = 0
    assign_user_random_room
    puts "You were attacked and died. You respawned but you lost all your crystals."
  end

  def assign_user_random_room
    @hashkeys = @world.rooms.keys
    @current_room = @world.rooms[@hashkeys[rand(@hashkeys.length)]]
    check_if_teleport_room
  end

  # This method will check if the current room is the teleport room and notifies the user of such
  def check_if_teleport_room
    if(@current_room.is_teleport_room)
      puts "~!~ This room has an ethereal quality. You notice the glowing dais in the center. ~!~"
      if(@crystals==1)
        puts "The crystal you collected is glowing."
      end
      if(@crystals>1)
        puts "The #{@crystals} crystals you have collected are glowing."
      end
      if(@crystals >= 5)
        @userWon = true
      end
    end
  end

  # This method handles movement including user room migration and blocked path notifications.
  # If a rooms direction is equal to 0, not another room, then that path is blocked.
  def user_move(direction)

    errorString = "Cant move that Way, Try a different Path"
    able_to_move = false

    case direction
    when "North","n","north"
      if(@current_room.north!= "0")
        @current_room = @world.rooms[current_room.north]
      able_to_move =true;
      else
        puts errorString
      able_to_move =false;
      end
    when "East","e","east"
      if(@current_room.east!="0")
        @current_room = @world.rooms[current_room.east]
      able_to_move =true;
      else
        puts errorString
      able_to_move =false;
      end
    when "South","s","south"
      if(@current_room.south!="0")
        @current_room = @world.rooms[current_room.south]
      able_to_move =true;
      else
        puts errorString
      able_to_move =false;
      end
    when "West","w","west"
      if(@current_room.west!="0")
        @current_room = @world.rooms[current_room.west]
      able_to_move =true;
      else
        puts errorString
      able_to_move =false;
      end
    when "quit"
      exit
    else
      puts "Invalid Direction / Invalid Statement"
      able_to_move =false;
    end

    puts "You are in room: "+ @current_room.title
    check_if_teleport_room

    return able_to_move

  end

end
