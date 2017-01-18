# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
Rails.application.config.assets.paths << Rails.root.join('vendor','assets','bower_components')

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
Rails.application.config.assets.precompile += %w( admin.css admin/datatables.css frontend.css amaze/frontend.css
  amaze_frontend.js
  amaze/frontend-bottom.js
  frontend.js frontend-bottom.js
  admin.js admin/datatables.js admin-bottom.js circles.js *.png *.jpg *.jpeg *.gif)