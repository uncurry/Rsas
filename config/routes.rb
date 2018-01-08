Rails.application.routes.draw do
  resources :rsas
  
  get "/rsas/:id/encrypt_messages" => "rsas#encrypt_messages"
  
  get "/rsas/:id/encrypt_messages/:id" => "rsas#show_encrypted"
  
  get "/rsas/:id/decrypt_messages" => "rsas#decrypt_messages"
  
  root 'rsas#index'

end
