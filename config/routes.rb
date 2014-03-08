TestTaskSubmitter::Application.routes.draw do
  resources :submissions, only: [:edit, :update, :show]
end
