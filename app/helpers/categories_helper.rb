module CategoriesHelper
  
  def render_tree(main_categories)
    content_tag :ul do
      main_categories.each do |category|
        concat(
          content_tag(:li) do
            content_tag(:span) do
              # concat link_to(category.name, edit_category_path(category))
              concat category.name
              concat ' '
            end
          end
        )
        concat(render_tree(category.subcategories)) if category.subcategories
      end
    end
  end

end
