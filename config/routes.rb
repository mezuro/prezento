Rails.application.routes.draw do
  devise_for :users 
  get 'users/:user_id/projects' => 'users#projects', as: :user_projects

  resources :projects do
    resources :repositories, except: [:update, :index]
    get '/repositories/:id/modules/:module_result_id' => 'repositories#show', as: :repository_module
    post '/repositories/:id/state' => 'repositories#state', as: :repository_state
    put '/repositories/:id' => 'repositories#update', as: :repository_update
    get '/repositories/:id/process' => 'repositories#process_repository', as: :repository_process
  end

  resources :mezuro_configurations do
    get '/metric_configurations/choose_metric' => 'metric_configurations#choose_metric', as: :choose_metric
    resources :metric_configurations, except: [:update, :new] do
      get '/mezuro_ranges/new' => 'mezuro_ranges#new', as: :new_mezuro_range
      resources :mezuro_ranges, except: [:update, :new]
      put '/mezuro_ranges/:id' => 'mezuro_ranges#update', as: :mezuro_range_update
    end
    post '/metric_configurations/new' => 'metric_configurations#new', as: :new_metric_configuration
    put '/metric_configurations/:id' => 'metric_configurations#update', as: :metric_configuration_update

    resources :compound_metric_configurations, except: [:destroy, :update]
    put '/compound_metric_configurations/:id' => 'compound_metric_configurations#update', as: :compound_metric_configuration_update
  end

  resources :reading_groups do
    resources :readings, except: [:index, :update, :show]
    put '/readings/:id' => 'readings#update', as: :reading_update
  end

  #resources :modules
  post '/modules/:id/metric_history' => 'modules#metric_history'
  post '/modules/:id/tree' => 'modules#load_module_tree'
  
  root "home#index"

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
