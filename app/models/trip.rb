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

  def self.filter_by_names(search_array, city, state, country)
    location_array = find_trips_by_location(city, state, country)
    name_filtered_array = []
    location_array.select do |trip|
      search_array.map do |name|
        if trip.name.downcase.include?(name.downcase)
          name_filtered_array << trip
        end
      end
    end
    name_filtered_array
  end

  def self.filter_by_tags(search_array, city, state, country)
    location_array = find_trips_by_location(city, state, country)
    tag_filtered_array = []
    location_array.select do |trip|
      search_array.map do |tag_name|
        trip.tags.each do |tag|
          if tag.name.downcase == tag_name.downcase
            tag_filtered_array << trip
          end
        end
      end
    end
    tag_filtered_array
  end

  def self.find_all_trips(search_array, city, state, country)
    name_trips = self.filter_by_names(search_array, city, state, country)
    tag_trips = self.filter_by_tags(search_array, city, state, country)
    all_trips = (name_trips + tag_trips).flatten.uniq
  end

  def self.find_trips_by_tags( search_array )
    tags = Tag.where( "lower(name) LIKE ANY ( array[ ? ] )", search_array )
    tag_trips = tags.map { | tag | tag.trips }
  end

  def self.find_trips_by_names( search_array )
    search = search_array.map { | name | "%#{ name.downcase }%" }
    trips = Trip.where( "lower(name) LIKE ANY ( array[?] )", search ).to_a
  end

  def self.find_trips_by_names_tags(search_array)
    all_trips = (self.find_trips_by_tags(search_array) + self.find_trips_by_names(search_array)).flatten.uniq
    return all_trips
  end

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
