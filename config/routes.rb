GrabItApi::Application.routes.draw do
  # devise_for :users
  devise_for :users, :controllers => {
    #:registrations => "registrations",
    :sessions => :sessions,
    :omniauth_callbacks => "users/omniauth_callbacks"
  } do
    get "logout" => "devise/sessions#destroy"
  end

  #match '/users', :controller => 'registrations', :action => 'create', :constraints => {:method => 'OPTIONS'}
  match '/users/sign_out', :controller => 'sessions', :action => 'destroy', :constraints => {:method => 'POST'}

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

  resources :posts do
    collection do
      get 'generate'
      post 'generate'
    end
  end

  resources :klasses do
    collection do
      get 'ongoing'
      get 'archived'
    end
  end

  resources :welcome
  resources :users do
    resources :tags
    resources :bookmarks

    collection do
      post 'subscribe'
      post 'unsubscribe'
    end
  end

  resources :bookmarks do
    collection do
      get 'search'
      get 'top'
      post 'elect'
      post 'collect'
    end
  end

  resources :tags do
    resources :bookmarks
    resources :users

    collection do
      get 'search'
      get 'top'
    end
  end

  #resources :tokens, :only => [:create, :destroy]
  resources :tokens do
    collection do
      get 'facebook'
      get 'evernote'
      get 'evernote_callback'
    end
  end

  resources :authorizations do
    collection do
      get 'facebook'
      get 'facebook_callback'
      get 'evernote'
      get 'evernote_callback'
    end
  end


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
  root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
