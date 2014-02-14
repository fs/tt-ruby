class SubmissionsController < ApplicationController
  expose(:submission, attributes: :submission_params)

  def create
    if submission.save
      run_submission
    else
      render :new
    end
  end

  private

  def run_submission
    system 'bin/run_submission'
  end

  def submission_params
    params.require(:submission).permit(:email, :source_code)
  end
end
