module Menu
  class Node
    attr_accessor :sub_nodes
    attr_accessor :name
    attr_accessor :link
    
    def initialize(name, link)
      @sub_nodes = []
      @name = name
      @link = link
    end
    
  end
end