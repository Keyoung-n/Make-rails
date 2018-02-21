Rails.application.routes.draw do
  post '/quote', to: 'quote#index'
end
