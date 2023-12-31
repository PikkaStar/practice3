Rails.application.routes.draw do


  get root to: "homes#top"
  get 'home/about'=>'homes#about',as: 'about'
  devise_for :users
  resources :books do
    resource :favorites,only: [:create,:destroy]
    resources :book_comments,only: [:create,:destroy]
  end
  resources :users,only: [:index,:show,:edit,:update]do
    resource :relationships,only: [:create,:destroy]
    get 'followings'=>'relationships#followings',as: 'followings'
    get 'followers'=>'relationships#followers',as: 'followers'
  end
  resources :messages, only: [:create]
  resources :rooms, only: [:create,:show]
  get "search"=>"searches#search",as: "search"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
