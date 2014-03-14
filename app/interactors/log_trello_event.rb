class LogTrelloEvent
  include Interactor

  def perform
    ActiveSupport::Notifications.instrument(
      'trello.event',
      action: action.attributes,
      model: model.attributes
    )
  end
end
