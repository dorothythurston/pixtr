Pixtr::Application.routes.draw do
  root "homes#show"

  get "/search" => "searches#index"
  resource :search, only: [:index]

  resource :dashboard, only: [:show]
  resources :galleries do
    member do
      post "like" => "gallery_likes#create"
      delete "unlike" => "gallery_likes#destroy"
    end
    resources :images, only: [:new, :create]
  end

  resources :groups do
    member do
      post "join" => "group_memberships#create"
      delete "leave" => "group_memberships#destroy"
      post "like" => "group_likes#create"
      delete "unlike" => "group_likes#destroy"
    end
  end

  resources :users, only: [:show] do
    member do
      post "follow" => "following_relationships#create"
      delete "unfollow" => "following_relationships#destroy"
    end
  end

  resources :comments, only:[:destroy]

  resources :tags, only:[:show]

  resources :images, except: [:index, :new, :create] do
    resources :comments, only:[:create,:show]
    member do
      post "like" => "image_likes#create"
      delete "unlike" => "image_likes#destroy"
    end
  end
end
