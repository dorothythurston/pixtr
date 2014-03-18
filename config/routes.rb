Pixtr::Application.routes.draw do
  root "homes#show"
  resources :galleries do
    resources :images, only: [:new, :create]
  end

  resources :groups

   resources :images, except: [:index, :new, :create] do
	resources :comments, only:[:create,:show] end
end
