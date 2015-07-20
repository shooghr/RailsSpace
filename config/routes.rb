Rails.application.routes.draw do

  get 'avatar/index'

  get 'avatar/upload'

  get 'avatar/delete'

  get 'community/index'

  get 'community/search'

  get 'faq/index'

  get 'faq/edit'
  post 'faq/edit'

  get 'spec/index'

  get 'spec/edit'
  post 'spec/edit'

  get 'profile/index'

  get 'profile/show'

  get 'user/index'
  post 'user/index'

  get 'user/register' => 'user#register'
  post 'user/register' => 'user#register'

  get 'user/edit'
  post 'user/edit'

  get 'user/login'
  post 'user/login'

  get 'user/logout'
  post 'user/logout'

  root 'site#index'

  get 'site/index'

  get 'site/about'

  get 'site/help'

  ###resources :profile

  ###get 'profile/:screen_name', to: 'profile#show'
  ###post 'profile/:screen_name', to: 'profile#show'

  match 'profile/:screen_name', to: 'profile#show', :as => :profile, via:[:get, :post]

  match 'user/index', :to => 'user#index', :as => :hub, via:[:get, :post]

  match ':controller/:action/:id', via:[:get, :post]

  match '', :controller => 'site', :action => 'index', :id => nil, via:[:get, :post]


      match 'browse' => 'community#browse', via:[:get, :post], as: :browse


  #ActionController::Routing::Routes.draw do |map|
    #map.connect 'profile/:screen_name', :controller => 'profile', :action => 'show'
    #map.connect ':controller/:action/:id'
  #end

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
