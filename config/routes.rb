Shubham::Application.routes.draw do
  
  get "pages/main"

  get "pages/about"

  get "pages/contact"

  get "pages/faq"

  #resources :habits
  devise_for :users, :controllers => { :registrations => "registrations" }
  
  devise_for :users do
    get "/account" => "registrations#edit"
  end
  
  resources :users do
    resources :tasks
    resources :habits
  end

  resources :blogs

  #resources :tasks

  resources :folders
  
  match "/update_task", :to => "tasks#update_task"
  match "/update_trace/:id", :to => "traces#update"
  match "/create_trace/:habit_id/:tracedate", :to => "traces#create"
  
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'pages#main'
  resque_constraint = lambda do |request|
    request.env['warden'].authenticate? and request.env['warden'].user.admin?
  end
  
  constraints resque_constraint do
    match "/delayed_job" => DelayedJobWeb, :anchor => false
  end

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
