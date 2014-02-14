class MailPreview < MailView
  def success
    mail = SubmissionMailer.success
  end
end
