class LogEventAndCreateSubmission
  include Interactor::Organizer

  organize [
    LogTrelloEvent,
    CreateSubmission
  ]
end
