require 'rexml/document'
include REXML
require_relative 'Room.rb'
require_relative 'User.rb'
require_relative 'Grue.rb'
require_relative 'ShortestPathAlgorithm.rb'
 # Describes world behavior
class World
  
attr_accessor :user
attr_accessor :rooms
attr_accessor :grue
DirectionalAdvice ="North={'north','n','North'}  East={'east','e','East'}  South={'south','s','South'}  West={'west','w','West'}   To Quit type 'quit'"

  def initialize(xmlFilePath,user)
    @user = user
    @rooms = Hash.new
    @grue = Grue.new(self)
    # Process the level which is saved as XML, the loop will create Room objects populate the @rooms hash for later use 
    xmldoc = Document.new(File.new(xmlFilePath))
    root = xmldoc.root
    xmldoc.elements.each("Level/Room/Title"){ 
        |e| room = Room.new(e.text,e.attributes["North"],e.attributes["East"],e.attributes["South"],e.attributes["West"],e.attributes["isTeleportRoom"])
        @rooms[room.title] = room
     }
      
     assignUserRandomRoom
     assignGrueToFarRoom
    puts DirectionalAdvice
  end
  
  #debug print method
  def printRooms
    @rooms.each {|key, value| puts "#{key} is #{value}" + "and teleportRoom =#{value.isTeleportRoom}" }
  end
  
  # This method is for setting the user into a random room, upon initialization and upon getting attacked.
  def assignUserRandomRoom
    @hashkeys = @rooms.keys
    @user.currentRoom = @rooms[@hashkeys[rand(@hashkeys.length)]]
  end
  
  #this method is for the initial spawn on Grue, We want to spawn him far away from the user
  def assignGrueToFarRoom
    @grue = Grue.new(self)
    @grue.setFarRoom(@user.currentRoom)
    updateGrueNextMove
  end
  
  
  #this will update Grues next move based on user position. Grue always moves to the room that is apart
  # of the shortest path to the user
  def updateGrueNextMove
    @grue.determineNextMove(@user.currentRoom)
  end
  
  
# This method will check if the current room is the teleport room and notifies the user of such
  def checkIfTeleportRoom
    if(@user.currentRoom.isTeleportRoom)
      puts "~!~ This room has an ethereal quality. You notice the glowing dais in the center. ~!~"
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
      if(@user.currentRoom.north!= "0")
        @user.currentRoom = @rooms[@user.currentRoom.north]
         wasAbleToMoveBool =true;
      else
        puts errorString
        wasAbleToMoveBool =false;
      end
    when "East","e","east"
      if(@user.currentRoom.east!="0")
        @user.currentRoom = @rooms[@user.currentRoom.east]
        wasAbleToMoveBool =true;
      else
        puts errorString
        wasAbleToMoveBool =false;
      end
    when "South","s","south"
      if(@user.currentRoom.south!="0")
        @user.currentRoom = @rooms[@user.currentRoom.south]
         wasAbleToMoveBool =true;
      else
        puts errorString
       wasAbleToMoveBool =false;
      end
    when "West","w","west"
      if(@user.currentRoom.west!="0")
        @user.currentRoom = @rooms[@user.currentRoom.west]
         wasAbleToMoveBool =true;
      else
        puts errorString
        wasAbleToMoveBool =false;
      end
     when "quit"
       exit
    else
      puts "Invalid Direction / Invalid Statement"
      puts DirectionalAdvice
      wasAbleToMoveBool =false;
    end
    
    # Check if you are in the teleport Room
    checkIfTeleportRoom
    updateGrueNextMove
    return wasAbleToMoveBool
    
    
  end
 
end

#world = World.new("sampleLevel.xml", User.new("Kevin"))





