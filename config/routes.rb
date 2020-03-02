Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'index' => "welcome#index"
  get 'about' => "welcome#about"
  get 'signup' => "users#new"
  root "welcome#index"
  resources:articles
  resources:users, except: [:new]
	get 'login' => "session#new"
	post 'login' => "session#create"
  get 'logout' => "session#destroy"
  get 'change_password' => "users#password"
  post 'change_password' => "users#updatepassword"
end
