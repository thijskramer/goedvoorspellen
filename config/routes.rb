Goedvoorspellen::Application.routes.draw do
   constraints(:host => "goedvoorspellen.nl") do
    # Won't match root path without brackets around "*x". (using Rails 3.0.3)
    match "(*x)" => redirect { |params, request|
      URI.parse(request.url).tap { |x| x.host = "www.goedvoorspellen.nl" }.to_s
    }, :via => [:get]
  end
 
  #resource :foo_bar
  #root :to => redirect('/foo_bar')

  #admin  
  namespace :admin do
    resources :teams, :coaches, :players, :clubs, :venues, :countries, :referees, :matches, :match_types, :groups, :scores, :substitutes, :bookings, :users, :penalties
    post '/players/:id/select', to: 'players#select'  
    resources :matches do
      member do
        get 'lineup'
        get 'scores'
        get 'substitutes'
        get 'bookings'
        get 'penalties'
      end
    end
    post '/lineups/toggle_lineup', to: 'lineups#toggle_lineup'
    get '/lineups/players', to: 'lineups#players'
    # get '/clubs/import', to: 'clubs#import' 
    # get '/countries/import', to: 'countries#import'
  end

  #
  #front
  #
  resources :poules do
    member do
      post 'join'
      get 'leave'
    end
  end
  scope(path_names: { }) do
    resources :venues, path: 'stadions'
    resources :teams, path: 'landen' do
      resources :players, path: 'spelers'
    end
    get '/wedstrijden/calendar', to: 'matches#calendar'
    resources :matches, path: 'wedstrijden'
    
    resources :groups, path: 'groepen'
    resources :predictions, path: 'voorspellingen'
    resources :clubs
  end

  #get '/landen/:team_id/spelers/:id', to: 'players#show', as: 'player'
  root 'home#placeholder'

  #authentication
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'help', to: 'home#help', as: 'help'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'
  get 'inloggen', to: 'login#index', as: 'login'

  get 'instellingen', to: 'user#settings', as: 'settings'
  patch 'account/verwijderen', to: 'user#remove', as: 'remove_account'
  patch 'instellingen/save', to: 'user#update', as: 'settings_save'
  get 'stand', to: 'rankings#index', as: 'rankings'

  #stats
  get 'stats', to: 'stats#index', as: 'stats'
  get 'stats/topscorers', to: 'stats#topscorers', as: 'topscorers'
  get 'stats/team-goals', to: 'stats#teamgoals', as: 'teamgoals'
  get 'stats/clubs', to: 'stats#clubs', as: 'statsclubs'

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
