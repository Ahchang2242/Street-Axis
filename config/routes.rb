Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/").
  root to: "home#index"

  # Navigation module pages
  get '/categories', to: 'home#categories', as: :categories
  get '/events', to: 'home#events', as: :events
  get '/about', to: 'home#about', as: :about
  get '/contact', to: 'home#contact', as: :contact

  # Devise routes for users
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  
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

  # Admin routes
  namespace :admin do
    root to: 'dashboard#index'
    resources :users, only: [:index, :show, :edit, :update, :destroy]
    resources :web_modules do
      patch :toggle, on: :member
    end
    resources :web_contents do
      patch :toggle_publish, on: :member
      get :preview, on: :member
    end
    resources :dance_styles do
      delete :remove_uploaded_image, on: :member
    end
    resources :events do
      delete :remove_uploaded_image, on: :member
    end
    resource :about_us, only: [:show, :edit, :update] do
      delete :remove_uploaded_image, on: :collection
    end
    resource :contact_info, only: [:show, :edit, :update] do
      delete :remove_uploaded_image, on: :collection
    end
    resources :roles
    resources :permissions
    resources :operation_logs, only: [:index, :show]
  end
end