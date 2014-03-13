class TrelloEventsController < ApplicationController
  expose(:trello_action, attributes: :trello_action_attributes)
  expose(:trello_model, attributes: :trello_model_attributes)

  respond_to :json, only: [:create]

  def create
    # log event data
  end

  private

  def trello_action_attributes
    params.require(:action).permit!
  end

  def trello_model_attributes
    params.require(:model).permit!
  end
end
