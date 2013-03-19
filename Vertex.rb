

class Vertex

# This is a helper class used to describe a vertex, This is helpful when performing the shortest path algorithm

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