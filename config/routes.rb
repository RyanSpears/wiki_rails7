Rails.application.routes.draw do
  get 'welcome/index'
  get 'welcome/about'
  get 'about', to: redirect('/welcome/about')

  resources :wiki_posts
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "welcome#index"
end
