module Pages
  class BasePage
    include Capybara::DSL
    include Rails.application.routes.url_helpers
  end
end