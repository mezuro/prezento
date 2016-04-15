Rails.application.routes.draw do
  scope "(:locale)", locale: /en|pt/ do
    devise_for :users
    get 'users/:user_id/projects' => 'users#projects', as: :user_projects

    resources :projects do
      resources :repositories, only: [:new, :create]
    end

    resources :repositories, except: [:update]
    get '/repositories/:id/modules/:module_result_id' => 'repositories#show', as: :repository_module
    get '/repositories/:id/state' => 'repositories#state', as: :repository_state
    get '/repositories/:id/state_with_date' => 'repositories#state_with_date', as: :repository_state_with_date
    put '/repositories/:id' => 'repositories#update', as: :repository_update
    # This route should be a POST to be semantically correct. But, RepositoriesController#create relies on a redirect to it which is not possible with a POST
    get '/repositories/:id/process' => 'repositories#process_repository', as: :repository_process
    get '/repository_branches' => 'repositories#branches', as: :repository_branches

    scope :format => false, :constraints => { :format => 'json' } do
      post '/repositories/:id/notify_push' => 'repositories#notify_push', as: :repository_notify_push, format: :json
    end

    resources :kalibro_configurations do
      get '/metric_configurations/choose_metric' => 'metric_configurations#choose_metric', as: :choose_metric
      resources :metric_configurations, except: [:update, :new] do
        get '/kalibro_ranges/new' => 'kalibro_ranges#new', as: :new_kalibro_range
        resources :kalibro_ranges, except: [:update, :new]
        put '/kalibro_ranges/:id' => 'kalibro_ranges#update', as: :kalibro_range_update
      end
      post '/metric_configurations/new' => 'metric_configurations#new', as: :new_metric_configuration
      put '/metric_configurations/:id' => 'metric_configurations#update', as: :metric_configuration_update

      resources :compound_metric_configurations, except: [:destroy, :update]
      put '/compound_metric_configurations/:id' => 'compound_metric_configurations#update', as: :compound_metric_configuration_update

      resources :hotspot_metric_configurations, only: [:create]
    end

    resources :reading_groups do
      resources :readings, except: [:index, :update, :show]
      put '/readings/:id' => 'readings#update', as: :reading_update
    end

    # Modules
    post '/modules/:id/metric_history' => 'modules#metric_history', as: 'module_metric_history'
    post '/modules/:id/tree' => 'modules#load_module_tree', as: 'module_tree'

    root "home#index"
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
