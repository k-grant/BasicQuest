
require_relative 'World.rb'
class Grue
 # Describes Grue behavior
 
 # Obtain a reference to the current world Grue lives in
 def initialize(worldReference)
   @currentWorld = worldReference
    @pathWeights = Hash.new
 end
 
 # Use some sort of shortest path algorithm to determine which move to make
 # This will be the room that takes Grue closest to the user
 def determineNextMove
   
 end
 
 # This method will be ran once in the initialization phase
 # It will find the distance from each room to each other room
 # It runs in O(N^2) where N= vertices which is very slow but only needs to be ran once at the start of the game so it is acceptable.
 def fillPathWeights
   @currentWorld.rooms.each {
     
     |key, value| 
     @currentWorld.rooms.each {
       |key2, value2| 
       if(key==key2)
        @pathWeights[key+"to"+key2]="sameroom"
       end
     }
   
   }
 end
 
 def returnShortestPath(from,to)
    shortestPath =99999
    path=""
    known = false
    while(!known)
      findAdjacentRooms(from).each do|n|

      end
    end

  end

 def findAdjacentRooms(from)
   return from.returnAdjacentRooms
 end
 
 # This method will determine which room to spawn Grue that is farthest from user
 def determineFarthestRoomFromUser
   
 end
 
 
end

world = World.new("sampleLevel.xml", User.new("Kevin"))
grue = Grue.new(world)
grue.fillPathWeights
