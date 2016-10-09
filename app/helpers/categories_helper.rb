module CategoriesHelper

  def category_logo(category)
    if category.logo
      return image_tag("categories/#{@category.logo}", width: "85px", height: "250px")
    end
    nil
  end

end
