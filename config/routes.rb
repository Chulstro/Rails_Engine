Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do

      namespace :items do
        get '/', to: 'items#index'
        get '/:id', to: 'items#show'
        post '/', to: 'items#create'
        patch '/:id', to: 'items#update'
        delete '/:id', to: 'items#destroy'
      end

      namespace :merchants do
        get '/', to: 'merchants#index'
        get '/:id', to: 'merchants#show'
      end
    end
  end
end
