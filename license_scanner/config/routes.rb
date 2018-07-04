Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  constraints format: :json do
    namespace :api do
      post 'scan'
      post 'gitlab'
      post 'github'
    end
  end
end
