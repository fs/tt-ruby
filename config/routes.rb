TestTaskSubmitter::Application.routes.draw do
  if Rails.env.development?
    mount MailPreview => 'mail_view'
  end

  resources :submissions, only: [:new, :create, :show]

  root 'submissions#new'
end
