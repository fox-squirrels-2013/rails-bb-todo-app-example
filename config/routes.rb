RefactorThis::Application.routes.draw do

  root :to => "ui#index"
  get '/mock', :to => "ui#mock"
  get '/server', :to => "ui#server", :as => :server_ui

  # non-api controllers
  resources :lists do
    resources :todos
  end

  namespace :api do
    resources :lists do
      resources :todos
    end
  end

end
