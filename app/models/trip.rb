class Trip < ActiveRecord::Base
  belongs_to :creator, class_name: "User", foreign_key: :user_id
  has_many :user_trips, :foreign_key => "attended_trip_id"
  has_many :attendees, :through => :user_trips
  has_many :locations, dependent: :destroy
  has_many :comments
  has_many :trip_tags
  has_many :tags, through: :trip_tags, dependent: :destroy
  has_many :favorites
  has_many :user_favorites, through: :favorites, source: :user
  has_many :requests
  has_many :user_requests, through: :requests, source: :user
  has_many :flags, as: :flaggable

  validates :name, presence: true
end
