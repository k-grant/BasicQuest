

class Vertex

attr_accessor :distance
attr_accessor :path
attr_accessor :roomObject
attr_accessor :title

def initialize(title,roomObject)
  @title = title
  @roomObject = roomObject
  @distance = Float::INFINITY
  @path=""
end




end