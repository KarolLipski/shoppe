module Menu 
  class Magazine
    attr_accessor :nodes
    attr_accessor :title
    delegate :url_helpers, to: 'Rails.application.routes'

    def initialize
      fetchCategories
      @title = 'Kategorie New'
    end

    def fetchCategories 
      @nodes = []
      categories = Category.main.order(:name)
      categories.each do |category|
        node = create_node(category)
        category.subcategories.each do |sub|
          node.sub_nodes << create_node(sub)
        end
        @nodes << node   
      end
    end

    def create_node(category) 
      Menu::Node.new("#{category.name} (#{category.items_count})",
          url_helpers.category_items_path(category))
    end
  end
end