require_relative 'vertex.rb'
require_relative 'shortestPathAlgorithm.rb'
require 'thread'

class Grue

  attr_accessor :world,:pathFinder,:current_room,:nextMove
  
  # Obtain a reference to the current world Grue lives in
  # Create objects for the curent room, world, pathFinder ( which supports graph algorithms ), and the next move grue will make
  def initialize(world_reference)
    @current_room =0
    @world=world_reference
    @pathFinder = ShortestPathAlgorithm.new(world_reference)
    @nextMove = " "
  end

  # This method will set Grues location to the room farthest away from the users room.
  def set_far_room(userPos)
    @current_room = @pathFinder.determine_farthest_room_from_user(userPos)
  end

  # Use some sort of shortest path algorithm to determine which move to make
  # This will be the room that takes Grue closest to the user
  def determine_next_move(userPos)
    @nextMove = @pathFinder.path_weights[@current_room.title][userPos.title].path.split[0]
  end

  def move_grue_to_user(userPos)
    grue_move(determine_next_move(userPos))
  end

  #If grue is attacked then move him randomly to adjacent room
  def grue_attacked
    puts "Grue is scared off, drops something shiny, and flees to an adjacent room!"
    moveRandomly
  end

  # Moves grue randomly to an adjacent room.
  def moveRandomly
    paths = @pathFinder.find_adjacent_rooms(@current_room)
    grue_move(paths[rand(paths.length)])
  end

  def returnDistanceToUser
    return @world.grue.pathFinder.path_weights[@world.grue.current_room.title][@world.user.current_room.title].distance
  end

  def grue_close_check
    if(@world.grue.returnDistanceToUser==1)
      puts "You hear a loud growl from one of the adjacent rooms!"
    end
  end

  # This method handles grue movement, he does not have to worry about blocked paths
  def grue_move(direction)
    case direction
    when "North","n","north"
      if(@current_room.north!= "0")
        @current_room = @world.rooms[@current_room.north]
      end
    when "East","e","east"
      if(@current_room.east!="0")
        @current_room = @world.rooms[@current_room.east]
      end
    when "South","s","south"
      if(@current_room.south!="0")
        @current_room = @world.rooms[@current_room.south]
      end
    when "West","w","west"
      if(@current_room.west!="0")
        @current_room = @world.rooms[@current_room.west]
      end
    end
    determine_next_move(@world.user.current_room)
  end

end

