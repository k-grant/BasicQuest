require_relative 'vertex.rb'
require 'thread'

class ShortestPathAlgorithm

  attr_accessor :vertices,:current_world,:path_weights
  
  # Obtain a reference to the current world
  def initialize(world_reference)
    @current_world = world_reference
    @path_weights = Hash.new
    @vertices = Hash.new

    # this fills up the vertices hash initially
    @current_world.rooms.each {
    |key, value|
      vertex = Vertex.new(key,value)
      @vertices[key] = vertex
    }

    #Here @path_weights is created and that stores the shortest distance and path from each node to every other node
    fill_path_weights

  end

  # This method will be ran once in the initialization phase
  # It will find the distance from each room to each other room
  def fill_path_weights

    #for each vertex, each level, find the shortest path to every node from that node and then add that data to path_weights
    hashkeys = @vertices.keys
    hashkeys.each do |n|
      @current_world.rooms.each {
      |key, value|
        vertex = Vertex.new(key,value)
        @vertices[key] = vertex
      }

      vertex = @vertices[n]
      return_shortest_path(vertex)
      vertices2 = @vertices.clone
      @path_weights[vertex.title]=vertices2
    end
  end

  # Here is the main method which finds the shortest distances for each node
  def return_shortest_path(from)

    queue = Queue.new
    queue << from
    from.distance = 0
    while(!queue.empty?)
      v= queue.pop
      count=0
      adjDir = find_adjacent_rooms(v.roomObject)
      while(count < adjDir.length)
        w = @vertices[v.roomObject.return_title(adjDir[count])]

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
  def find_adjacent_rooms(from)
    return from.return_adjacent_rooms
  end

  # This method will determine which room to spawn Grue that is farthest from user
  def determine_farthest_room_from_user(user_pos)
    max =-999
    room = nil
    @path_weights.each{
    |key,value|
      value.each{
      |key2,value2|
        if(key2==user_pos.title)
          if(value2.distance > max)
          max = value2.distance
          room = @current_world.rooms[key]
          end
        end
      }
    }
    return room
  end

end
