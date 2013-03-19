require 'rexml/document'
include REXML
require_relative 'Room.rb'
require_relative 'User.rb'
class World
  
attr_accessor :user
attr_accessor :rooms
DirectionalAdvice ="North={'north','n','North'}  East={'east','e','East'}  South={'south','s','South'}  West={'west','w','West'}   To Quit type 'quit'"
 # Describes world behavior
  def initialize(xmlFilePath,user)
    @user = user
    @rooms = Hash.new
    
    # Process the level which is saved as XML, the loop will create Room objects populate the @rooms hash for later use 
    xmldoc = Document.new(File.new(xmlFilePath))
    root = xmldoc.root
    xmldoc.elements.each("Level/Room/Title"){ 
        |e| room = Room.new(e.text,e.attributes["North"],e.attributes["East"],e.attributes["South"],e.attributes["West"],e.attributes["isTeleportRoom"])
        #puts e.attributes("isTeleportRoom")
        @rooms[room.title] = room
     }
      
     assignUserRandomRoom
    puts DirectionalAdvice
  end
  
  #debug print method
  def printRooms
    @rooms.each {|key, value| puts "#{key} is #{value}" + "and teleportRoom =#{value.isTeleportRoom}" }
  end
  
  # This method is for setting the user into a random room, upon initialization and upon getting attacked.
  def assignUserRandomRoom
    @hashkeys = @rooms.keys
    user.currentRoom = @rooms[@hashkeys[rand(@hashkeys.length)]]
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
    return wasAbleToMoveBool
    
    
  end
 
end

#world = World.new("sampleLevel.xml", User.new("Kevin"))
#world.printRooms





