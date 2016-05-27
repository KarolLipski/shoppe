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

  def category_logo(category)
    if category.logo
      return image_tag("categories/#{@category.logo}", width: "85px", height: "250px")
    end
    nil
  end

  def menu_item_url(category, type, offer)
    if type == :magazine
      category_items_path(category)
    else
      category_offer_items_path(category, offer)
    end
  end

  def category_items_name(category, type)
    if type == :magazine
      "#{category.name} (#{category.items_count})"
    else
      "#{category.name}"
    end
  end

  def category_items_link(category, type, offer)
    if type == 'mag'
      link_to category.name + " (#{category.items_count})", category_items_path(category)
    else
      link_to category.name, category_offer_items_path(category, offer)
    end
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

  def tab_class(type)
    case type
      when 'mag'
        klass = (!session[:active_tab] || session[:active_tab] == 'mag') ? 'active': nil
      when 'offer'
        klass = (session[:active_tab] == 'offer') ? 'active': nil
    end
    return klass
  end

end
