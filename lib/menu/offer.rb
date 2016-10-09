module Menu 
  class Offer < Magazine
    attr_accessor :nodes
    attr_accessor :offer

    def initialize
      set_offer
      @title = @offer.name
      fetchCategories
    end

    def set_offer
      @offer = ::Offer.active
    end

    def offer_ids
      ids = []
      offer_categories = Category.all_for_offer(@offer)
      offer_categories.each do |cat|
        ids << cat.id
        ids << cat.parent_id if cat.parent_id
      end
      ids.to_set
    end

    def fetchCategories 
      @nodes = []
      categories = Category.main.order(:name)
      offer_category_ids = offer_ids
      categories.each do |category|
        if offer_category_ids.include?(category.id)
          node = create_node(category)
          category.subcategories.each do |sub|
            node.sub_nodes << create_node(sub) if offer_category_ids.include?(sub.id)
          end
          @nodes << node
        end
      end
    end

    def create_node(category) 
      Menu::Node.new(category.name, url_helpers.category_offer_items_path(category, offer))
    end



  end
end