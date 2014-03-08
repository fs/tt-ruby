class SubmissionsController < ApplicationController
  include ActionController::Live

  expose(:submission, attributes: :submission_params)

  respond_to :json, only: [:create]

  def show
    response.headers['Content-Type'] = 'text/event-stream'

    CheckCode.new(submission).read do |line|
      response.stream.write "data: #{line}\n\n"
    end

    response.stream.close
  end

  def create
    submission.save

    respond_with(submission, responder: JsonResponder)
  end

  private

  def submission_params
    params.require(:submission).permit(:source_code)
  end
end
