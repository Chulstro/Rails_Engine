Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do

      namespace :items do
        get '/', to: 'items#index'
        post '/', to: 'items#create'
        get '/find', to: 'find#show'
        get '/:id', to: 'items#show'
        patch '/:id', to: 'items#update'
        delete '/:id', to: 'items#destroy'
      end

      namespace :merchants do
        get '/', to: 'merchants#index'
        post '/', to: 'merchants#create'
        get '/find', to: 'find#show'
        get '/:id', to: 'merchants#show'
        patch '/:id', to: 'merchants#update'
        delete '/:id', to: 'merchants#destroy'
      end
    end
  end
end
