class Trip < ActiveRecord::Base
  belongs_to :creator, class_name: "User", foreign_key: :user_id
  has_many :user_trips
  has_many :tourists, through: :user_trips, source: :user
  has_many :locations
  has_many :comments
  has_many :trip_tags
  has_many :tags, through: :trip_tags
  has_many :favorites
  has_many :user_favorites, through: :favorites, source: :user

  validates :name, presence: true, uniqueness: true
end


