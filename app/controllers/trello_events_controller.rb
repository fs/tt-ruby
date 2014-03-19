class TrelloEventsController < ApplicationController
  expose(:trello_action) { TrelloAction.new(trello_action_attributes) }
  expose(:trello_model) { TrelloModel.new(trello_model_attributes) }

  respond_to :json, only: [:create]
  before_action :switch_params

  def create
    result = LogEventAndCreateSubmission.perform(action: trello_action, model: trello_model)

    if result.success?
      # leave edit_submission_path(result.submission) in trello card comments
    else
      Rails.logger.debug "TRELLO EVENT: invalid callback request parameters"
    end

    render nothing: true
  end

  private

  def switch_params
    params[:trello_action] = raw_params['action']
    params[:trello_model] = raw_params['model']
  end

  def raw_params
    Rack::Utils.parse_nested_query(request.raw_post)
  end

  def trello_action_attributes
    params.require(:trello_action).permit!
  end

  def trello_model_attributes
    params.require(:trello_model).permit!
  end
end
