Rails.application.routes.draw do
  post '/quote/', to: 'quote#index'
  get '/test', to: 'quote#show'
end
