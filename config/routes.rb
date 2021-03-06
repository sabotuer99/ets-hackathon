Rails.application.routes.draw do
  resources :profiles
  get 'login/login'

  resources :states
  get 'states/index'

  get 'login', to: 'login#login', as: 'login_page'

  get 'items/nearby' => 'items#nearby'

  resources :agencies
  resources :items
  resources :states

  get 'reports/index'
  get 'reports' => 'reports#index'
  get 'reports/agency' => 'reports#agency'
  get 'reports/user' => 'reports#user'
  get 'reports/userpie' => 'reports#userpie'

  get 'qr/index'
  get 'qr' => 'qr#index'

  get 'map/index'
  get 'map' => 'map#index'

  get 'sessions/create'

  get 'sessions/destroy'

  get 'welcome/index'
  
  resources :welcome
  get '/about' => 'welcome#about'
  get '/contact' => 'welcome#contact'

  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'

  resources :sessions, only: [:create, :destroy]


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'

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
