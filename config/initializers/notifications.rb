ActiveSupport::Notifications.subscribe 'trello.event' do |name, start, finish, id, payload|  
  Rails.logger.debug "TRELLO EVENT: from #{start} to #{finish}"
  Rails.logger.debug "  action: #{payload[:action]}"
  Rails.logger.debug "  model: #{payload[:model]}"
end
