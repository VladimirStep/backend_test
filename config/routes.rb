Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace 'api' do
    namespace 'v1' do
      resources :publishers, only: [] do
        resources :shops, only: [:index]
      end
      resources :shops, only: [] do
        resources :books, only: [] do
          member do
            post 'sell'
          end
        end
      end
    end
  end
end
