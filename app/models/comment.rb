class Comment < ActiveRecord::Base
  belongs_to :trip
  belongs_to :user
  has_many :flags, as: :flaggable
end
