

require_relative 'Vertex.rb'
require_relative 'ShortestPathAlgorithm.rb'
require 'thread'
class Grue
 # Describes Grue behavior
  attr_accessor :world
  attr_accessor :pathFinder
  attr_accessor :grueCurrentRoom
 # Obtain a reference to the current world Grue lives in
 def initialize(worldReference)
   @grueCurrentRoom =0
   @world=worldReference
   @pathFinder = ShortestPathAlgorithm.new(worldReference)
 end
 
 def setWorld(worldReference)
   @world=worldReference
   @pathFinder = ShortestPathAlgorithm.new(worldReference)
 end
 
def setFarRoom(userPos)
  @grueCurrentRoom = @pathFinder.determineFarthestRoomFromUser(userPos).roomObject
end
 
 # Use some sort of shortest path algorithm to determine which move to make
 # This will be the room that takes Grue closest to the user
 def determineNextMove(userPos)
   
 end
 

 #world = World.new("sampleLevel.xml", User.new("Kevin"))

  #  world.grue.pathFinder.pathWeights.each {
  # |key, value| 
   #  farRoom = world.grue.pathFinder.determineFarthestRoomFromUser(key)
   #    puts " from: #{key} the most distant room is #{farRoom.title} with distance #{farRoom.distance} with path : #{farRoom.path}"
  #  value.each{
   #   |key2, value2| 
   #    puts " from :  #{key}  to : #{key2} has distance #{value2.distance} with path #{value2.path.split}"
            
   # }
   # }
     
end


