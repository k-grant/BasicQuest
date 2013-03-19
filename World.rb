require 'rexml/document'
include REXML
require './Room.rb'
require './User.rb'
class World
  
attr_accessor :user

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
 
 
 
 
 
end

world = World.new("sampleLevel.xml",User.new("Kevin"));
world.printRooms
puts world.user.currentRoom



