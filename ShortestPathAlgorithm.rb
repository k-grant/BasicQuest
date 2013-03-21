require_relative 'vertex.rb'
require 'thread'

class ShortestPathAlgorithm

  attr_accessor :vertices,:currentWorld,:pathWeights
  
  # Obtain a reference to the current world
  def initialize(worldReference)
    @currentWorld = worldReference
    @pathWeights = Hash.new
    @vertices = Hash.new

    # this fills up the vertices hash initially
    @currentWorld.rooms.each {
    |key, value|
      vertex = Vertex.new(key,value)
      @vertices[key] = vertex
    }

    #Here @pathweights is created and that stores the shortest distance and path from each node to every other node
    fillPathWeights

  end

  # This method will be ran once in the initialization phase
  # It will find the distance from each room to each other room
  def fillPathWeights

    #for each vertex, each level, find the shortest path to every node from that node and then add that data to pathweights
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

  # Here is the main method which finds the shortest distances for each node
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

  # Returns adjacent Rooms, or adjacent directions leading to rooms
  def findAdjacentRooms(from)
    return from.returnAdjacentRooms
  end

  # This method will determine which room to spawn Grue that is farthest from user
  def determineFarthestRoomFromUser(userPos)
    max =-999
    room = nil
    @pathWeights.each{
    |key,value|
      value.each{
      |key2,value2|
        if(key2==userPos.title)
          if(value2.distance > max)
          max = value2.distance
          room = @currentWorld.rooms[key]
          end
        end
      }
    }
    return room
  end

end