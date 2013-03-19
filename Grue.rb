class Grue
 # Describes Grue behavior
 
 # Obtain a reference to the current world Grue lives in
 def initialize(worldReference)
   @currentWorld = worldReference
 end
 
 # Use some sort of shortest path algorithm to determine which move to make
 # This will be the room that takes Grue closest to the user
 def determineNextMove
   
 end
 
 # This method will be ran once in the initialization phase
 # It will find the distance from each room to each other room
 # It runs in O(N^2) where N= vertices which is very slow but only needs to be ran once at the start of the game so it is acceptable.
 def fillPathWeights
   
 end
 
 # This method will determine which room to spawn Grue that is farthest from user
 def determineFarthestRoomFromUser
   
 end
 
 
end