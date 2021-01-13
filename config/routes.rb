Rails.application.routes.draw do
  devise_for :users
  namespace :api, defaults: { format: JSON } do
    namespace :v1 do
      devise_scope :user do
        post 'register', to: 'registrations#create'
        post 'login', to: 'sessions#create'
        delete 'logout', to: 'sessions#destroy'
      end
    end
  end
end
