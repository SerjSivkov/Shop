Shop::Application.routes.draw do
  get 'admin' => 'admin#index'
  controller :sessions do |variable|
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end

  #get 'sessions/new'

  get 'sessions/create'
  get 'sessions/destroy'

  resources :users
  resources :orders
  resources :line_items
  resources :carts
  get 'store/index'

  resources :products do
  	get :who_bought, on: :member
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'store#index', as: 'store'
end
