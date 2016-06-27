class User < ActiveRecord::Base
  has_many :trips, dependent: :destroy
  has_many :user_trips, :foreign_key => :attendee_id
  has_many :attended_trips, :through => :user_trips, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_trips, through: :favorites, source: :trip, dependent: :destroy
  has_many :requests, dependent: :destroy
  has_many :requested_trips, through: :requests, source: :trip, dependent: :destroy
  has_many :flags, dependent: :destroy
  has_many :active_relationships, class_name: :Relationship, foreign_key: 'follower_id', dependent: :destroy

  validates :first_name, :last_name, presence: true
  acts_as_messageable

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [ :facebook ]

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.first_name = auth.info.name.split()[0]   # assuming the user model has a name
      user.last_name = auth.info.name.split()[-1]
      user.picture_url = "#{ auth.info.image }?type=large" # assuming the user model has an image
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def mailboxer_name
    self.name
  end

  def mailboxer_email(object)
    self.email
  end

  def formatted_name
    self.first_name.capitalize + " " + self.last_name[0].capitalize + "."
  end

  def attending?(trip)
    trip.attendees.include?(self)
  end

  def attend!(trip)
    self.user_trips.create!(attended_trip_id: trip.id)
  end

  def cancel!(trip)
    self.user_trips.find_by(attended_trip_id: trip.id).destroy
  end

  def favorite?(trip)
    self.favorited_trips.include?(trip)
  end

  def total_trip_attendees
    self.trips.map { |trip| trip.attendees.count }.reduce(:+)
  end

  def common_trips
    common_interests = []
    common_trips = []

    tag_name = []

    self.trips.each do | trip |
      trip.tags.each do | tag |
        common_interests << tag if !tag_name.include? tag.name
        tag_name << tag.name
      end
    end

    common_interests.each do | tag |
      tag.trips.each do | trip |
        if !self.attended_trips.include?( trip ) && trip.creator != self
          common_trips << trip
        end
      end
    end
    common_trips
  end

  def followers_count
    Relationship.where(followed_id: self.id).length
  end

  def following_count
    Relationship.where(follower_id: self.id).length
  end

  def user_followed?( current_user )
    Relationship.find_by( follower_id: current_user.id, followed_id: self.id )
  end

  def followers_for
    Relationship.where(followed_id: self.id)
  end

  def following
   Relationship.where( follower_id: self.id )
  end

  def followers
    followers = []
    self.followers_for.each do |user|
      followers << User.find_by(id: user.follower_id)
    end
    followers
  end

  def followed
    followed_users = []
    self.following.each do |user|
      followed_users << User.find_by(id: user.followed_id)
    end
    followed_users
  end

  def get_followed_trips
    followed_trips = []
    self.followed.each do |user|
      followed_trips << user.trips
    end
    followed_trips
  end

end
