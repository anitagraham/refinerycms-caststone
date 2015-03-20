Refinery::Core::Engine.routes.draw do

  get '/system/drawings/*dragonfly', :to => Dragonfly.app(:caststone_drawings)
  get '/system/photos/*dragonfly', :to => Dragonfly.app(:caststone_photos)
  get '/templates/:path/:name', :to =>  "caststone/templates#serve"
  get '/refinery/caststone/products/:id/:type/list', :to =>  "caststone/products#list"

# ------------- Products = Series --------------


  # Admin routes
  namespace :caststone, :path => '' do
    namespace :admin, :path => 'refinery/caststone' do
      resources :products do
        collection do
          post :update_positions
        end
         resources :components,  :bases, :shafts, :capitals, :columns, :letterboxes
      end
    end
  end

# ------------- Components --------------

  # Admin routes
  namespace :caststone, :path => '' do
    namespace :admin, :path => 'refinery/caststone' do
      resources :components, :bases, :shafts, :capitals, :columns, :letterboxes,  :controller=>'components', :except => :show do
      	collection do
          get :draw
          post :update_positions
        end
      end
    end
  end

# ------------- Photos --------------

  # Admin routes
  namespace :caststone, :path => '' do
    namespace :admin, :path => 'refinery/caststone' do
      resources :photos, :except => :show do
        get :view,  :on=> :member
        # get :add_copyright, :on => :member
        post :update_positions, :on=>:collection
        # get :insert, :on => :collection
        resources :components, :bases, :shafts, :capitals, :columns, :letterboxes, :controller=>'components'
      end
    end
  end

  # Frontend routes
  namespace :caststone, :path=>'refinery/caststone' do
    resources :photos, :only => [:draw, :details] do
      member do
        get :draw, :details
      end
    end
  end
end
