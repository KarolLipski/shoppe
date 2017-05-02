module Pages
  class MainRoot < BasePage

    def visit_page
      visit root_path
    end

    def on_page?
      has_selector?('.slider-section')
    end
  end
end