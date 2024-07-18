Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      root 'notes#index'
      resources :notes do
        collection do
          post 'enqueue_templates', to: 'notes#enqueue_templates'
        end
      end
    end
  end
end
