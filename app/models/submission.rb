class Submission < ActiveRecord::Base
  validates_presence_of :email, :source_code
end
