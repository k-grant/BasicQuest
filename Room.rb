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
  
  ## Accessor Methods for Paths
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
  
  def returnTitle(string)
    case string
    when "north"
       @paths[0]
    when "east"
      @paths[1]
    when "south"
      @paths[2]
    when "west"
      @paths[3]
    end
    
  end
  
  ##############################
 def returnAdjacentRooms
      returnArray =Array.new
      counter =0
      if(@paths[0]!="0")
        returnArray[counter]="north"
      counter = counter +1
      end
      if(@paths[1]!="0")
        returnArray[counter]="east"
      counter = counter +1
      end
      if(@paths[2]!="0")
        returnArray[counter]="south"
      counter = counter +1
      end
      if(@paths[3]!="0")
        returnArray[counter]="west"
      counter = counter +1
      end
      return returnArray
    end

    
 

 # Describes room behavior
end

