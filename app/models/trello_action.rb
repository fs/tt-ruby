class TrelloAction < TrelloEntity
  field :id
  field :idMemberCreator
  field :data
  field :type
  field :date
  field :memberCreator

  validates :id,
    :idMemberCreator,
    :data,
    :type,
    :date,
    :memberCreator,
    presence: true
end
