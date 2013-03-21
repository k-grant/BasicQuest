
require_relative 'game.rb'

class Main
  game = Game.new("sampleLevel.xml")
  game.loop
end