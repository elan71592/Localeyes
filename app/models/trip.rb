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

  def self.sort_by_favorites
    Trip.all.sort_by{|trip| trip.favorites.count}.reverse
  end

  def self.find_trips_by_location(city, state, country)
    Trip.where(city: city, state: state, country: country)
  end

  def self.find_trips_by_tags( search_array )
    tags = Tag.where( "name LIKE ANY ( array[ ? ] )", search_array )
    tags.map { | tag | tag.trips }
  end

  def self.find_trips_by_names( search_array )
    search = search_array.map { | name | "%#{ name }%" }
    Trip.where( "name LIKE ANY ( array[?] )", search ).to_a
  end

  def self.find_all_trips( search_array, city, state, country )
    location_trips = find_trips_by_location(city, state, country)
    name_trips = find_trips_by_names(search_array)
    tag_trips = find_trips_by_tags(search_array)
    ( name_trips + tag_trips + location_trips ).flatten.uniq
  end
end
