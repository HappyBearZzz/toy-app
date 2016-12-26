Rails.application.routes.draw do

  resources :chatinfos
  get 'about' => 'about#index'
  get "chat_group/:activity_id", to: "chatinfos#chat_group"
  get "chat_onetoone/:to_userid", to: "messages#chat_onetoone"
  root 'users#login'
  get 'home' => 'activities#index'
  resources :admins
  resources :messages
  resources :replies
  resources :relationships
  resources :comments do
    resources :replies
  end
  resources :activities
  resources :participations
  resources :users do
    resources :participations
    resources :activities
    resources :comments
    resources :relationships
  end
  
  controller :messages do
    get 'two_chat/:to_userid'=>:two_chat
    get 'peer_history/:to_userid'=>:peer_history
  end
  controller :chatinfos do
    get 'enter_chat/:activity_id'=>:enter_chat
    get 'group_history/:activity_id'=>:group_history
  end
  controller :users do
    get 'register'=>:new
    post 'register'=>:create
    get 'change_password'=>:change_password
    post 'update_password'=>:update_password
    get 'set_password/:user_id' => 'users#set_password'
    post 'reset_password'=>:reset_password
    get 'login'=>:login
    post 'login'=>:login_confirm
    delete 'logout'=>:logout
  end
  controller :admins do
    get 'adminlogin'=>:adminlogin
    post 'adminlogin'=>:adminlogin_confirm
    delete 'adminlogout'=>:adminlogout
  end
  controller :participations do
    get 'addtoactivity/:activity_id'=>:addtoactivity
    get 'approve_participation/:participation_id/:activity_id'=>:approve_participation
    get 'refuse_participation/:participation_id/:activity_id'=>:refuse_participation
  end
  controller :activities do
  end
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
