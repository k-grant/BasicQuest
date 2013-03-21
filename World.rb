require 'rexml/document'
include REXML
require_relative 'Room.rb'
require_relative 'User.rb'
require_relative 'Grue.rb'
require_relative 'ShortestPathAlgorithm.rb'
 # Describes world behavior
class World
  
attr_accessor :user,:rooms,:grue
DirectionalAdvice ="North={'north','n','North'}  East={'east','e','East'}  South={'south','s','South'}  West={'west','w','West'}   To Quit type 'quit'"

  def initialize(xmlFilePath)
    @user = User.new(self)
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
    @user = User.new(self)
    @hashkeys = @rooms.keys
    @user.currentRoom = @rooms[@hashkeys[rand(@hashkeys.length)]]
    puts "You are in room: "+ @user.currentRoom.title
    @user.checkIfTeleportRoom
  end
  
  #this method is for the initial spawn on Grue, We want to spawn him far away from the user
  def assignGrueToFarRoom
    @grue = Grue.new(self)
    @grue.setFarRoom(@user.currentRoom)
    @grue.determine_next_move(@user.currentRoom)
  end
  
  
  
  
end

#world = World.new("sampleLevel.xml")





