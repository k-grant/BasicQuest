class Room
  attr_accessor :title
  
  def initialize(title, north, east, south, west)
    @title=title
    @paths = [north,east,south,west]
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