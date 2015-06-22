module CategoriesHelper
  
  def render_tree(main_categories)
    content_tag :ul do
      main_categories.each do |category|
        concat(
          content_tag(:li) do 
            concat link_to(category.name, edit_category_path(category))
            concat ' '
          end
        )
        concat(render_tree(category.subcategories)) if category.subcategories
      end
    end
  end

end
