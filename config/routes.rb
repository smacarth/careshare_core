CareshareCore::Application.routes.draw do
  match "/pills/find", to: "pills#find", via: [:get, :post]
  match "/pills/create_pill", to: "pills#create_pill", via: [:get, :post]
  match "/pills/reminders", to: "pills#reminders", via: [:get, :post]
 match "/pills/refills", to: "pills#refills", via: [:get, :post]
 
  resources :alerts do
    get :make_call, :reminder, :directions, :goodbye, :thankyou
    post :make_call, :reminder, :directions, :goodbye, :thankyou
  end
  
  resources :pills do
    get :add_periods, :show_periods, :update_pills
  end
  
  resources :inventories
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'home#index'

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
