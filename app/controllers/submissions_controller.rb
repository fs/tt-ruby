class SubmissionsController < ApplicationController
  include ActionController::Live

  expose(:submission, attributes: :submission_params)

  respond_to :json, only: [:create]

  def create
    submission.save

    respond_with(submission, responder: JsonResponder)
  end

  private

  def submission_params
    params.require(:submission).permit(:email, :source_code)
  end
end
