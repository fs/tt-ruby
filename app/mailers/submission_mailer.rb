class SubmissionMailer < ActionMailer::Base
  default from: "from@example.com"

  def success
    mail(to: "to@example.com", subject: 'Success')
  end
end
