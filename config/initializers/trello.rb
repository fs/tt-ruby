if defined?(Trello)
  Trello.configure do |config|
    config.developer_public_key = ENV['TRELLO_DEVELOPER_KEY']
    config.member_token = ENV['TRELLO_MEMBER_TOKEN']
  end
end
