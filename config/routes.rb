TestTaskSubmitter::Application.routes.draw do
  if Rails.env.development?
    mount MailPreview => 'mail_view'
  end

  resources :submissions, only: [:new, :create]

  root 'submissions#new'
end
