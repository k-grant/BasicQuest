

require_relative 'Vertex.rb'
require_relative 'ShortestPathAlgorithm.rb'
require 'thread'
class Grue
 # Describes Grue behavior
  attr_accessor :world
  attr_accessor :pathFinder
  attr_accessor :grueCurrentRoom
  attr_accessor :nextMove
  
  
 # Obtain a reference to the current world Grue lives in
 # Create objects for the curent room, world, pathFinder ( which supports our graph algorithms ), and the next move grue will make
 def initialize(worldReference)
   @grueCurrentRoom =0
   @world=worldReference
   @pathFinder = ShortestPathAlgorithm.new(worldReference)
   @nextMove = " "
 end
 
 # This method will set Grues location to the room farthest away from the users room
def setFarRoom(userPos)
  @grueCurrentRoom = @pathFinder.determineFarthestRoomFromUser(userPos).roomObject
end
 
 # Use some sort of shortest path algorithm to determine which move to make
 # This will be the room that takes Grue closest to the user
 def determineNextMove(userPos)
   @nextMove = @pathFinder.pathWeights[@grueCurrentRoom.title][userPos.title].path.split[0]
 end
 
 #If grue is attacked then move him randomly to adjacent room
 def grueAttacked
   puts "Grue is scared off, drops something shiny, and flees to an adjacent room!"
   #drop crystal
   moveRandomly
 end
 
 # Moves grue randomly to an adjacent room
 def moveRandomly
   paths = @pathFinder.findAdjacentRooms(@grueCurrentRoom)
   grueMove(paths[rand(paths.length)])
 end
 
 def returnDistanceToUser
   return @world.grue.pathFinder.pathWeights[@world.grue.grueCurrentRoom.title][@world.user.currentRoom.title].distance
 end
 
 # This method handles grue movement, he does not have to worry about blocked paths
  def grueMove(direction)
    case direction
    when "North","n","north"
      if(@grueCurrentRoom.north!= "0")
        @grueCurrentRoom = @world.rooms[@grueCurrentRoom.north]
      end
    when "East","e","east"
      if(@grueCurrentRoom.east!="0")
        @grueCurrentRoom = @world.rooms[@grueCurrentRoom.east]
      end
    when "South","s","south"
      if(@grueCurrentRoom.south!="0")
        @grueCurrentRoom = @world.rooms[@grueCurrentRoom.south] 
      end
    when "West","w","west"
      if(@grueCurrentRoom.west!="0")
        @grueCurrentRoom = @world.rooms[@grueCurrentRoom.west]
      end
    end
   determineNextMove(@world.user.currentRoom)
  end
 
end


