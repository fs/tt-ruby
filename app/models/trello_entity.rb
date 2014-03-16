class TrelloEntity
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_reader :attributes

  def self.field(name)
    define_method(name) { @attributes[name] }
    define_method("#{name}=") { |value| @attributes[name] = value }
  end

  def initialize(attributes = {})
    @attributes = {}
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def persisted?
    false
  end
end
