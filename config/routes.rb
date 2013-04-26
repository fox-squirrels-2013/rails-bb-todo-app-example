RefactorThis::Application.routes.draw do

  root :to => "ui#index"

  # todo: namespace :api do
  resources :lists do
    resources :todos
  end

end
