class User
 # Describes User behavior
 attr_accessor :name
 attr_accessor :crystals
 attr_accessor :currentRoom
  attr_accessor :world
  attr_accessor :userWon
 
 # initialize name and number of crystals
 def initialize(worldReference)
    @name 
    @crystals =0
    @world = worldReference
    @currentRoom
    @userWon = false
 end
 
 # Method called by User when he picks up a crystal
 def pickUpCrystal
   @crystals = crystals+1
 end
 
 # Method called when user is attacked, respawn will be handeled by the world
 def userAttacked
   @crystals = 0
   assignUserRandomRoom
   puts "You were attacked and died. You respawned but you lost all your crystals."
 end
 
 def assignUserRandomRoom
    @hashkeys = @world.rooms.keys
    @currentRoom = @world.rooms[@hashkeys[rand(@hashkeys.length)]]
     
  end
 
 
 # This method will check if the current room is the teleport room and notifies the user of such
  def checkIfTeleportRoom
    if(@currentRoom.isTeleportRoom)
      
      puts "~!~ This room has an ethereal quality. You notice the glowing dais in the center. ~!~"
      puts "The #{@crystals} crystals you have collected are glowing."
      if(@crystals > 5)
        @userWon = true
      end
    end
  end
 
 
 # This method handles movement including user room migration and blocked path notifications.
  # If a rooms direction is equal to 0, not another room, then that path is blocked.
  def userMove(direction)
    
    errorString = "Cant move that Way, Try a different Path"
    #set this bool to false or true depending on if path exists
    # I set it up like this so that I could check if the next room, or the current room again, is the teleport Room before returning
    # Also necessary to check for Grue proximity in each room
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
    
    # Check if you are in the teleport Room
    checkIfTeleportRoom
    
    return wasAbleToMoveBool
    
    
  end
 
end