Connie::Application.routes.draw do
  devise_for :users

  # The priority is based upon order of creation:
  # first created -> highest priority.

  resources :conventions do
    member do
      put 'set_as_default'
      match 'roles/:role_department/profiles' => 'profiles#index'
      get 'settings'
    end

    collection do
      put 'remove_default'
      put 'set_default'
    end

    resources :profiles do
      resources :roles
    end

    resources :events
    resources :spaces
    resources :jobs do
      resources :assignees
    end
    resources :schedules
    resources :periods
    resources :auth_requirements
  end

  resources :events do
    resource :time_span
    resources :reservations
    resources :comments
    post 'rules/create' => 'rules#create'
    get 'rules/new' => 'rules#new'
  end

  resources :spaces do
    resources :maps
  end

  resources :tag_groups do
    resources :tags
  end

  resources :profiles do
    resources :phones
    resources :roles
  end

  match 'roles/:role_department/profiles' => 'profiles#index'

  resources :time_spans
  resources :roles
  resources :jobs do
    resources :comments
    resources :assignees
  end

  resources :users do
    resource :profile
  end

  match 'rules/:rule_type/:rule_id' => 'rules#destroy', :via => :delete

  match 'reset_session' => 'application#reset_app_session'

  match 'search' => 'searches#show'

  resources :comments
  match 'comments/:parent_id/reply' => 'comments#new', :as => 'new_comment_reply'

  # Schedule routes
  match 'schedules' => 'schedules#index'
  match 'schedules/:start/to/:end/maps/:space_ids' => 'schedules#show'

  # Helper for Chronic parsing
  # Constraints to deal with periods per http://stackoverflow.com/questions/6719797/need-a-rails-route-with-a-possible-period-in-the-id-but-also-retain-the-option
  match 'chronic/:text' => 'time_spans#chronic_parse', :constraints => {
      :text => /[\w\d.,%:\-']+?/, :format => /json/}

  root :to => 'application#index'

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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
