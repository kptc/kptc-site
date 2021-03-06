Rails.application.routes.draw do
  
  devise_for :players,
    controllers: {
      registrations: 'registrations'
    }
  
  root to: 'home#index'
  get 'home', to: 'home#index'
  
  get 'players', to: 'players#index'
  put 'player/:id/admin', to: 'players#toggle_admin', as: 'player_admin'
  put 'player/:id/activate', to: 'players#toggle_activate', as: 'player_activate'
  get 'player/:id/profile', to: 'players#show', as: 'player'
  get 'player/:id/calendar', to: 'players#calendar', as: 'calendar'

  get 'sessions/:id/build', to: 'sessions#build', as: 'session_build'
  patch 'sessions/:id/update_session_players', to: 'sessions#update_session_players', as: 'update_session_players'
  
  resources :sessions
  patch 'player_sessions/:player_id/select', to: 'player_sessions#select', as: 'player_sessions_select'
  
  resources :session_times
  patch 'player_session_times/:id/request_sub/:player_id', to: 'player_session_times#request_sub'
  patch 'player_session_times/:player_id/cancel_sub', to: 'player_session_times#cancel_sub', as: 'cancel_sub'
  patch 'player_session_times/:player_id/take_sub', to: 'player_session_times#take_sub', as: 'take_sub'
  patch 'player_session_times/:player_id/enter_score', to: 'player_session_times#enter_score', as: 'enter_score'

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
