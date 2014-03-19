TestTaskSubmitter::Application.routes.draw do
  resources :submissions, only: [:edit, :update, :show]
  resources :trello_events, only: [:create]
end
