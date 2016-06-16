class Trip < ActiveRecord::Base
  belongs_to :creator, class_name: "User", foreign_key: :user_id
  has_many :user_trips, foreign_key: "attended_trip_id", dependent: :destroy
  has_many :attendees, through: :user_trips, dependent: :destroy
  has_many :locations, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :trip_tags
  has_many :tags, through: :trip_tags, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :user_favorites, through: :favorites, source: :user
  has_many :requests, dependent: :destroy
  has_many :user_requests, through: :requests, source: :user
  has_many :flags, as: :flaggable

  validates :name, presence: true

  def self.sort_by_favorites
    Trip.all.sort_by{|trip| trip.favorites.count}.reverse
  end

  #Method for filtering search query and calling correct method

  def self.filter_and_search(search_array, city, state, country)
    if search_array.empty? && ( !city.empty? || !state.empty? || !country.empty? )
      search_location( city, state, country )
    elsif !search_array.empty? && ( city.empty? && state.empty? && country.empty? )
      search_names_and_tags( search_array )
    else
      search_names_tags_and_location( search_array, city, state, country )
    end
  end

  #Search method for location with no tag or name input

  def self.search_location(city, state, country)
    trips = Trip.where("lower( city ) = :city AND lower( state ) = :state AND lower( country ) = :country", { city: city.downcase, state: state.downcase, country: country.downcase })
  end

  #Search methods for name, tag, and location input

  def self.filter_by_names(search_array, city, state, country)
    location_array = search_location(city, state, country)
    name_filtered_array = []
    location_array.select do |trip|
      search_array.map do |name|
          name_filtered_array << trip if trip.name.downcase.include?(name.downcase)
      end
    end
    name_filtered_array
  end

  def self.filter_by_tags(search_array, city, state, country)
    location_array = search_location(city, state, country)
    tag_filtered_array = []
    location_array.select do |trip|
      search_array.map do |tag_name|
        trip.tags.each do |tag|
            tag_filtered_array << trip if tag.name.downcase == tag_name.downcase
        end
      end
    end
    tag_filtered_array
  end

  def self.search_names_tags_and_location(search_array, city, state, country)
    name_trips = self.filter_by_names(search_array, city, state, country)
    tag_trips = self.filter_by_tags(search_array, city, state, country)
    (name_trips + tag_trips).flatten.uniq
  end

  #Search methods for name and tag search without location input

  def self.find_all_trips_by_tags( search_array )
    tags = Tag.where( "lower(name) LIKE ANY ( array[ ? ] )", search_array )
    tag_trips = tags.map { | tag | tag.trips }
  end

  def self.find_all_trips_by_names( search_array )
    search = search_array.map { | name | "%#{ name.downcase }%" }
    trips = Trip.where( "lower(name) LIKE ANY ( array[?] )", search ).to_a
  end

  def self.search_names_and_tags(search_array)
    (self.find_all_trips_by_tags(search_array) + self.find_all_trips_by_names(search_array)).flatten.uniq
  end

  #Comment methods

  def creator_comments
    self.comments.where(user_id: self.creator.id)
  end

  def user_comments
    self.comments - creator_comments
  end

  def self.shuffle_trips( recommended_trips, followed_trips )
    if !recommended_trips.empty? && !followed_trips.empty?
      recommended_trips.push(followed_trips.flatten!)
    elsif !recommended_trips.empty?
      recommended_trips
    elsif !followed_trips.empty?
      followed_trips
    else
      []
    end
  end

  def trip_complete?
    self.locations.length >= 3
  end

end
