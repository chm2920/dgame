Dgame::Application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'start#index'
  

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  resources :rounds do
    member do
      get 'show'
    end
    
    collection do
      get 'index'
    end
  end

  # Example resource route with options:
  resources :users do
    member do
    end

    collection do
      get 'login'
      get 'main'
      get 'logout'
      post 'login_rst'
      post 'reg_rst'
    end
  end

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

  namespace :admin do
    get "main" => "manage#main"
    get "start_game" => "manage#start_game"
    get "pause_game" => "manage#pause_game"
    get "sys_reset" => "manage#sys_reset"
    
    get "users" => "manage#users"
    get "rounds" => "manage#rounds"
  end
  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
