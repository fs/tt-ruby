class SubmissionsController < ApplicationController
  include ActionController::Live

  expose(:submission, attributes: :submission_attributes)

  respond_to :json, only: [:update]

  def show
    response.headers['Content-Type'] = 'text/event-stream'

    CheckCode.new(submission).read do |line|
      response.stream.write "data: #{line}\n\n"
    end

    response.stream.close
  end

  def edit
  end

  def update
    submission.attributes = submission_attributes
    submission.save

    respond_with(submission, responder: JsonResponder)
  end

  private

  def submission_attributes
    params.require(:submission).permit(:source_code)
  end
end
