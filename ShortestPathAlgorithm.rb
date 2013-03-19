

require_relative 'Vertex.rb'
require 'thread'
class ShortestPathAlgorithm
  
  attr_accessor :vertices
  attr_accessor :currentWorld
  attr_accessor :pathWeights
 # Obtain a reference to the current world
 def initialize(worldReference)
   @currentWorld = worldReference
    @pathWeights = Hash.new
    @vertices = Hash.new
    

      @currentWorld.rooms.each {
     |key, value| 
     vertex = Vertex.new(key,value)
     @vertices[key] = vertex
     }
     fillPathWeights
    
    
 end
 
 # This method will be ran once in the initialization phase
 # It will find the distance from each room to each other room
 # It runs in O(N^2) where N= vertices which is very slow but only needs to be ran once at the start of the game so it is acceptable.
 def fillPathWeights

    hashkeys = @vertices.keys
    hashkeys.each do |n|
      @currentWorld.rooms.each {
      |key, value|
        vertex = Vertex.new(key,value)
        @vertices[key] = vertex
      }

      vertex = @vertices[n]
      returnShortestPath(vertex)
      vertices2 = @vertices.clone
      @pathWeights[vertex.title]=vertices2
    end
  end
 
 def returnShortestPath(from)
   
   
   queue = Queue.new
   queue << from
   from.distance = 0
    while(!queue.empty?)
      v= queue.pop
      count=0
      adjDir = findAdjacentRooms(v.roomObject)
      while(count < adjDir.length)
        w = @vertices[v.roomObject.returnTitle(adjDir[count])]
        
        if(w.distance==Float::INFINITY)
          w.distance = v.distance + 1
          w.path = v.path + " " + adjDir[count].to_s()
          queue << w
        end
        count = count + 1
      end
      count=0
    end

  end

 def findAdjacentRooms(from)
   return from.returnAdjacentRooms
 end
 

 
 # This method will determine which room to spawn Grue that is farthest from user
 def determineFarthestRoomFromUser(userPos)
   max =-999
   room = nil
   @pathWeights[userPos.title].each{
     |key,value|
        if(value.distance > max)
          max = value.distance
          room = value
        end
     
   }
   return room
 end
 

 
 
 
end