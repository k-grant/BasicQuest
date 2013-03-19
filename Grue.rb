

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
 
end


