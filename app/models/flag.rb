class Flag < ActiveRecord::Base
  validates :flagged, presence: true

  belongs_to :user
  belongs_to :flaggable, polymorphic: true
end
