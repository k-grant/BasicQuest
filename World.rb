require 'rexml/document'
include REXML
require_relative 'Room.rb'
require_relative 'User.rb'
class World
  
attr_accessor :user
attr_accessor :rooms

 # Describes world behavior
  def initialize(xmlFilePath,user)
    @user = user
    @rooms = Hash.new
    
    # Process the level which is saved as XML, the loop will create Room objects populate the @rooms hash for later use 
    xmldoc = Document.new(File.new(xmlFilePath))
    root = xmldoc.root
    xmldoc.elements.each("Level/Room/Title"){ 
        |e| room = Room.new(e.text,e.attributes["North"],e.attributes["East"],e.attributes["South"],e.attributes["West"])
        @rooms[room.title] = room
     }
      
     assignUserRandomRoom

  end
  
  #debug print method
  def printRooms
    @rooms.each {|key, value| puts "#{key} is #{value}" }
  end
  
  # This method is for setting the user into a random room, upon initialization and upon getting attacked.
  def assignUserRandomRoom
    @hashkeys = @rooms.keys
    user.currentRoom = @rooms[@hashkeys[rand(@hashkeys.length)]]
  end
  
  
  # This method handles movement including user room migration and blocked path notifications.
  def userMove(direction)
    errorString = "Cant move that Way"
    case direction
    when "North"
      if(@user.currentRoom.north!= "0")
        @user.currentRoom = @rooms[@user.currentRoom.north]
         return true;
      else
        puts errorString
        return false;
      end
    when "East"
      if(@user.currentRoom.east!="0")
        @user.currentRoom = @rooms[@user.currentRoom.east]
        return true;
      else
        puts errorString
        return false;
      end
    when "South"
      if(@user.currentRoom.south!="0")
        @user.currentRoom = @rooms[@user.currentRoom.south]
         return true;
      else
        puts errorString
        return false;
      end
    when "West"
      if(@user.currentRoom.west!="0")
        @user.currentRoom = @rooms[@user.currentRoom.west]
         return true;
      else
        puts errorString
        return false;
      end
    else
      puts "Invalid Direction"
      return false;
    end
    
    
  end
 
 
 
 
 
end





