class User
 # Describes User behavior
 attr_accessor :name
 attr_accessor :crystals
 attr_accessor :currentRoom
 
 # initialize name and number of crystals
 def initialize(name)
   @name = name
    @crystals =0
 end
 
 # Method called by User when he picks up a crystal
 def pickUpCrystal
   @crystals = crystals+1
 end
 
 # Method called when user is attacked, respawn will be handeled by the world
 def userAttacked
   @crystals = 0
 end
 
end