Pixtr::Application.routes.draw do
  root "homes#show"
  resources :galleries do
    resources :images, only: [:new, :create]
  end

  resources :groups

  resources :users, only: [:show] do
    member do
      post "follow" => "following_relationships#create"
      delete "unfollow" => "following_relationships#destroy"
    end
  end

  resources :images, except: [:index, :new, :create] do
	resources :comments, only:[:create,:show]
  end
end
