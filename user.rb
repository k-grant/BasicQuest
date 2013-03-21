class User

  attr_accessor :crystals,:currentRoom,:world,:userWon
  # initialize name and number of crystals
  def initialize(worldReference)
    @crystals =0
    @world = worldReference
    @currentRoom=nil
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
    @currentRoom = @world.rooms[@hashkeys[rand(@hashkeys.length)]]
    check_if_teleport_room
  end

  # This method will check if the current room is the teleport room and notifies the user of such
  def check_if_teleport_room
    if(@currentRoom.is_teleport_room)
      puts "~!~ This room has an ethereal quality. You notice the glowing dais in the center. ~!~"
      if(@crystals==1)
        puts "The crystal you collected is glowing."
      end
      if(@crystals>1)
        puts "The #{@crystals} crystals you have collected are glowing."
      end
      if(@crystals > 5)
        @userWon = true
      end
    end
  end

  # This method handles movement including user room migration and blocked path notifications.
  # If a rooms direction is equal to 0, not another room, then that path is blocked.
  def user_move(direction)

    errorString = "Cant move that Way, Try a different Path"
    wasAbleToMoveBool = false

    case direction
    when "North","n","north"
      if(@currentRoom.north!= "0")
        @currentRoom = @world.rooms[currentRoom.north]
      wasAbleToMoveBool =true;
      else
        puts errorString
      wasAbleToMoveBool =false;
      end
    when "East","e","east"
      if(@currentRoom.east!="0")
        @currentRoom = @world.rooms[currentRoom.east]
      wasAbleToMoveBool =true;
      else
        puts errorString
      wasAbleToMoveBool =false;
      end
    when "South","s","south"
      if(@currentRoom.south!="0")
        @currentRoom = @world.rooms[currentRoom.south]
      wasAbleToMoveBool =true;
      else
        puts errorString
      wasAbleToMoveBool =false;
      end
    when "West","w","west"
      if(@currentRoom.west!="0")
        @currentRoom = @world.rooms[currentRoom.west]
      wasAbleToMoveBool =true;
      else
        puts errorString
      wasAbleToMoveBool =false;
      end
    when "quit"
      exit
    else
      puts "Invalid Direction / Invalid Statement"
      wasAbleToMoveBool =false;
    end

    puts "You are in room: "+ @currentRoom.title
    check_if_teleport_room

    return wasAbleToMoveBool

  end

end
