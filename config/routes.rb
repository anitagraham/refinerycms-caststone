Refinery::Core::Engine.routes.draw do

  get '/system/drawings/*dragonfly', to: Dragonfly.app(:caststone_drawings)
  get '/system/photos/*dragonfly',   to: Dragonfly.app(:caststone_photos)
  get '/templates/:path/:name',      to: "caststone/templates#serve"
  get '/refinery/caststone/products/:id/:type/list', to: "caststone/products#list"

  # Admin routes
  namespace :caststone, :path => '' do
    namespace :admin, :path => 'refinery/caststone' do

      # ------------- Products = Series --------------
      resources :products do
        collection do
          post :update_positions
        end
        resources :components,  :bases, :shafts, :capitals, :columns, :letterboxes
      end

      # ------------- Components --------------
      resources :components, :bases, :shafts, :capitals, :columns, :letterboxes,
                controller: 'components', except: :show do
        collection do
          get :draw
          post :update_positions
        end
      end

      # ------------- Photos --------------
      resources :photos, except: :show do
        get :view, on: :member
        post :update_positions, on: :collection
        resources :components, :bases, :shafts, :capitals, :columns, :letterboxes, controller: 'components'
      end

    end
  end


  # Frontend routes
  namespace :caststone, path: 'refinery/caststone' do
    resources :photos, only: [:draw, :details] do
      member do
        get :draw, :details
      end
    end
    resources :products, only: :show
  end

end
