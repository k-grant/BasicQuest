class Room
  attr_accessor :title
  attr_accessor :isTeleportRoom
 
  def initialize(title, north, east, south, west ,isTeleportRoom)
    @title=title
    @paths = [north,east,south,west]
     if(isTeleportRoom=="0")
      @isTeleportRoom = false
    else
      @isTeleportRoom = true
    end
      
  end
  
  def north
    @paths[0]
  end
  
    def east
    @paths[1]
  end
  
   def south
    @paths[2]
  end
  
   def west
    @paths[3]
  end
  

 # Describes world behavior
end