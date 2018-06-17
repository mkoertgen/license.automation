Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :hooks do
    constraints format: :json do
      post 'gitlab'
      post 'github'
    end
  end
end
