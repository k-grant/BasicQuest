class Room

  attr_accessor :title,:is_teleport_room
  
  def initialize(title, north, east, south, west ,is_teleport_room)
    @title=title
    @paths = [north,east,south,west]
    if(is_teleport_room=="0")
      @is_teleport_room = false
    else
      @is_teleport_room = true
    end

  end

  # Accessor Methods for Paths
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

  def return_title(string)
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
end

