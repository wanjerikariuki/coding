
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  Rails.application.routes.draw do
    root 'shortened_urls#index'
    get 'shortened_urls/index'


    get '/:short_url', to: 'shortened_urls#show'
    get 'shortened/:short_url', to: 'shortened_urls#shortened', as: :shortened
    post'/shortened_urls/create'
    get '/shortened_urls/fetch_original_url'

  end

