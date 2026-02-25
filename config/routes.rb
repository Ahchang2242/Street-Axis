Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/").
  root to: "home#index"

  # Devise routes for users
  devise_for :users
  
  # User profile routes
  get '/user/profile', to: 'users#profile', as: :user_profile
  get '/user/edit', to: 'users#edit', as: :edit_user_profile
  patch '/user/update', to: 'users#update', as: :update_user_profile
  get '/user/security', to: 'users#security', as: :user_security
  patch '/user/update_password', to: 'users#update_password', as: :update_user_password
  
  # User courses routes
  get '/user/courses', to: 'users#courses', as: :user_courses
  get '/user/courses/new', to: 'users#new_course', as: :new_user_course
  post '/user/courses', to: 'users#create_course', as: :create_user_course
  get '/user/courses/:id/edit', to: 'users#edit_course', as: :edit_user_course
  patch '/user/courses/:id', to: 'users#update_course', as: :update_user_course
  delete '/user/courses/:id', to: 'users#destroy_course', as: :destroy_user_course
end