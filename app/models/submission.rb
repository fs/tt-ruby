class Submission < ActiveRecord::Base
  validates :source_code,
    presence: true,
    length: { maximum: 4000 }
end
