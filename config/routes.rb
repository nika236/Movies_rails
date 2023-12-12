Rails.application.routes.draw do
  root "pages#home"
  get '/about', to: 'pages#about'
  resources :movies , shallow: true do
    resources :reviews, except: [:index, :new, :edit]
  end
  devise_for :users

end
