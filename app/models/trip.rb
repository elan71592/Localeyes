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

  def creator_comments
    self.comments.where(user_id: self.creator.id)
  end

  def user_comments
    self.comments - creator_comments
  end

  def self.shuffle_trips( recommended_trips, followed_trips )
    if recommended_trips != nil && followed_trips != nil
      recommended_trips.push(followed_trips.flatten!)
    elsif recommended_trips != nil
      recommended_trips
    elsif followed_trips != nil
      followed_trips
    else
      []
    end
  end

  def trip_complete?
    self.locations.length >= 3
  end
end
