class User
 # Describes User behavior
 attr_accessor :name
 attr_accessor :crystals
 attr_accessor :currentRoom
 
 def initialize(name)
   @name = name
    @crystals =0
 end
 
 def pickUpCrystal
   @crystals = crystals+1
 end
 
 def userAttacked
   @crystals = 0
 end
 
end