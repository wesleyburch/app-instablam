Rails.application.routes.draw do
  mount Shrine.presign_endpoint(:cache) => "/s3/params"
  devise_for :user
  resources :photos
  get '/:creator_id/photos' => 'photos#user_wall', as: :user_wall

  devise_scope :user do
    authenticated :user do
      root 'photos#index', as: :authenticated_root
    end
    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
