Rails.application.routes.draw do

  root to: 'main#index'

  get '/items/main', to: 'items#index', as: :items_main
  get '/items/offer/:offer_id', to: 'offer#index', as: :offer_main

  get '/categories/:category_id/items(.:format)', to: 'stored_items#index', as: :category_items
  get '/categories/:category_id/offers/:offer_id/items(.:format)', to: 'offer_items#index', as: :category_offer_items

  namespace :admin do
    root to: 'dashboard#main'
    resources :offers
    resources :categories
    resources :users
    resources :items, only: [:index, :update]
    get '/items/actualization', to: 'items#actualization', as: :items_actualization
    post '/items/actualize', to: 'items#actualize', as: :items_actualize
    get 'items/noCategories', to: 'items#no_categories', as: :items_no_categories
    get 'items/noPhotos', to: 'items#no_photos', as: :items_no_photos
    get '/offers/actualization/:offer_id', to: 'offers#actualization', as: :offers_actualization
  end

  resources :cart_items
  resources :orders , only: [:create, :new, :index] do
    resources :order_items, only: [:index]
  end

  get '/cart/init_add/:item_id', to: 'carts#init_add', as: :cart_init_add

  get '/search', to: 'main#search', as: :search

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
