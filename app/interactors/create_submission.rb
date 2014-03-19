class CreateSubmission
  include Interactor

  def perform
    submission = Submission.new(source_code: 'blank code')
    if submission.save
      context[:submission] = submission
    else
      context.fail!
    end
  end
end
