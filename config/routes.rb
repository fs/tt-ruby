TestTaskSubmitter::Application.routes.draw do
  resources :submissions, only: [:new, :create]

  root 'submissions#new'
end
