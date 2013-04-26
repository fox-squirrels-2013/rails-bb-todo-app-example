RefactorThis::Application.routes.draw do

  root :to => "ui#index"
  get '/mock', :to => "ui#mock"

  # todo: namespace :api do
  resources :lists do
    resources :todos
  end

end
