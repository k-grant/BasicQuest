require 'rexml/document'
include REXML
require_relative 'Room.rb'
require_relative 'User.rb'
require_relative 'Grue.rb'
require_relative 'ShortestPathAlgorithm.rb'

 # Describes world behavior
class World
  
attr_accessor :user,:rooms,:grue

DIRECTIONAL_ADVICE ="North={'north','n','North'}  East={'east','e','East'}  South={'south','s','South'}  West={'west','w','West'}   To Quit type 'quit'"

 def initialize(xml_file_path)
    @user = User.new(self)
    @rooms = Hash.new
    @grue = Grue.new(self)
    # Process the level which is saved as XML, the loop will create Room objects populate the @rooms hash for later use
    xmldoc = Document.new(File.new(xml_file_path))
    root = xmldoc.root
    xmldoc.elements.each("Level/Room/Title"){
    |e| room = Room.new(e.text,e.attributes["North"],e.attributes["East"],e.attributes["South"],e.attributes["West"],e.attributes["isTeleportRoom"])
      @rooms[room.title] = room
    }

    assign_user_random_room
    assign_grue_far_room
    puts DIRECTIONAL_ADVICE
  end
  
  #debug print method
  def print_rooms
    @rooms.each {|key, value| puts "#{key} is #{value}" + "and teleportRoom =#{value.is_teleport_room}" }
  end
  
  # This method is for setting the user into a random room, upon initialization and upon getting attacked.
  def assign_user_random_room
    @user = User.new(self)
    @hashkeys = @rooms.keys
    @user.current_room = @rooms[@hashkeys[rand(@hashkeys.length)]]
    puts "You are in room: "+ @user.current_room.title
    @user.check_if_teleport_room
  end
  
  #This method is for the initial spawn on Grue, We want to spawn him far away from the user
  def assign_grue_far_room
    @grue = Grue.new(self)
    @grue.set_far_room(@user.current_room)
    @grue.determine_next_move(@user.current_room)
  end
end






