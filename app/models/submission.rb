class Submission < ActiveRecord::Base
  EMAIL = /\A[^@]+@[^@]+\z/

  validates :email,
    presence: true,
    format: { with: EMAIL }

  validates :source_code,
    presence: true,
    length: { maximum: 4000 }
end
