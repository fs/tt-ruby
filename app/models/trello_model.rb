class TrelloModel < TrelloEntity
  field :id
  field :name
  field :desc
  field :closed
  field :idOrganization
  field :pinned
  field :url
  field :prefs
  field :labelNames

  validates :id,
    :name,
    :url,
    presence: true
end
