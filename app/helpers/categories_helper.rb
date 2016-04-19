module CategoriesHelper
  
  def render_tree(main_categories)
    content_tag :ul do
      main_categories.each do |category|
        concat(
          content_tag(:li) do
            content_tag(:span) do
              concat category.name
              concat ' '
            end
          end
        )
        concat(render_tree(category.subcategories)) if category.subcategories
      end
    end
  end

  def category_heading_name(category)
    return "#{category.parent.name}: #{category.name}" unless category.parent.nil?
    return "#{category.name}"
  end

  def category_name_with_count(category, type)
    postfix = (type == 'mag') ? " (#{category.items_count})" : ""
    category.name + postfix
  end

  def collapsed_id(type, category)
    type+'_'+category.name.gsub(' ','')
  end

  def collapsed_category_name(type, category)
    if type == 'mag'
      category.name+" (#{category.items_count})"
    else
      category.name
    end
  end

end
