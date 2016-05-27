class MenuGenerator

  attr_accessor :has_offer
  attr_accessor :offer

  def initialize
    @offer = Offer.active
    @has_offer = !@offer.nil?
    @root_categories = Category.main.order(:name)
  end

  def magazine_categories
    categories = []
    @root_categories.each do |category|
      sub_categories = []
      category.subcategories.each do |sub|
        sub_categories << sub
      end
      categories <<  { category: category, subcategories: sub_categories }
    end
    return {categories: categories, type: :magazine, title: 'Kategorie'}
  end

  def offer_categories
    categories = []
    offer_cat_ids = offer_ids

    @root_categories.each do |category|
      if offer_cat_ids.include?(category.id)
        sub_categories = []
        category.subcategories.each do |sub|
          sub_categories << sub if offer_cat_ids.include?(sub.id)
        end
        categories <<  { category: category, subcategories: sub_categories }
      end
    end
    return {categories: categories, type: :offer, title: @offer.name, offer: @offer}
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

end