Rails.application.routes.draw do
  resources :appointments
  resources :patients do
  	  resources :visits
  	end
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'static_pages#home'
  get'/static_pages/:hospreq' => "static_pages#hospreq"

end
