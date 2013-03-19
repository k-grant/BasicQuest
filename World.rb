require 'rexml/document'
include REXML
require './Room.rb'
class World

 # Describes world behavior
  def initialize(xmlFilePath)
    xmlfile = File.new(xmlFilePath)
    xmldoc = Document.new(xmlfile)
    root = xmldoc.root
    @rooms = Hash.new
    xmldoc.elements.each("Level/Room/Title"){ 
        |e| room = Room.new(e.text,e.attributes["North"],e.attributes["East"],e.attributes["South"],e.attributes["West"])
        @rooms[room.title] = room
     }

  end
  
  def printRooms
    @rooms.each {|key, value| puts "#{key} is #{value}" }
  end
  
 
 
 
 
 
end

world = World.new("sampleLevel.xml");
world.printRooms



