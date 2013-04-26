RefactorThis::Application.routes.draw do

  # todo: namespace :api do
  resources :lists do
    resources :todos
  end

end
