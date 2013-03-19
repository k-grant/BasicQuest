
require_relative 'World.rb'
require_relative 'Vertex.rb'
require 'thread'
class Grue
 # Describes Grue behavior
 attr_accessor :vertices
  attr_accessor :currentWorld
  attr_accessor :pathWeights
 # Obtain a reference to the current world Grue lives in
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
 
 
 def returnFreshVertices
   freshVertices = Hash.new
         @currentWorld.rooms.each {
     |key, value| 
     vertex = Vertex.new(key,value)
     freshVertices[key] = vertex
     }
     return freshVertices
 end
 
 # Use some sort of shortest path algorithm to determine which move to make
 # This will be the room that takes Grue closest to the user
 def determineNextMove
   
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

      puts vertex.title
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
     # puts "Looking at #{v.title}"
     #  puts "With distance #{v.distance}"
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
   @pathWeights[userPos].each{
     |key,value|
        if(value.distance > max)
          max = value.distance
          room = value
        end
     
   }
   return room
 end
 
 
 
 
 
 world = World.new("sampleLevel.xml", User.new("Kevin"))
grue = Grue.new(world)
    grue.pathWeights.each {
   |key, value| 
     farRoom = grue.determineFarthestRoomFromUser(key)
       puts " from: #{key} the most distant room is #{farRoom.title} with distance #{farRoom.distance} with path : #{farRoom.path}"
    value.each{
      |key2, value2| 
       puts " from :  #{key}  to : #{key2} has distance #{value2.distance} with path #{value2.path.split}"
            
    }
    }
     
end


