class SubmissionsController < ApplicationController
  include ActionController::Live

  expose(:submission, attributes: :submission_params)

  def create
    response.headers['Content-Type'] = 'text/event-stream'
    result = CheckCode.new(submission)

    result.read do |line|
      response.stream.write line
    end

    response.stream.close
  end

  private

  def submission_params
    params.require(:submission).permit(:email, :source_code)
  end
end
