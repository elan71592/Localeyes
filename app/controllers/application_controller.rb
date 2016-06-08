class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  # PANSAMPANSAM
  # API clients that are app dependent, rather than user dependent
  # should be initialized once upon your app loading and then be
  # available henceforth. I.e: this is not a controller concern.
  # You are instantiating a new Client with every request here.
  # I would put these app-specific API client initializers in a well
  # named file in your initializers folder and scope them as CONSTANTS.
  def google_client
    @client ||= GooglePlaces::Client.new( ENV[ 'GOOGLE_PLACES_KEY' ] )
  end

  # PANSAMPANSAM
  # Ditto to above. Put the auth part of this in an initializer.
  # It also seems like this work would be done well by a module or
  # a service object. Think about abstracting it to your concerns folder.
  def upload_pic( image )
    auth = {
      cloud_name: "localeyes-trips",
      api_key:    ENV[ "CLOUDINARY_KEY" ],
      api_secret: ENV[ "CLOUDINARY_SECRET" ]
    }

    image = Cloudinary::Uploader.upload( Rails.root.join( 'public', 'uploads', image ), auth )
    image[ 'url' ]
  end

  # PANSAMPANSAM
  # This feels like model logic. Maybe also something that ActiveRecord /
  # Postgres could do faster than Ruby?
  def sort_by_favorites( trip_list )
    trip_list.sort_by{|trip| trip.favorites.count}.reverse
  end

  # PANSAMPANSAM
  # Model logic...
  # In fact almost all of this file feels like model logic.
  def find_trips_by_tags( search_array )
    tags = Tag.where( "name LIKE ANY ( array[ ? ] )", search_array )
    tags.map { | tag | tag.trips }
  end

  def find_trips_by_names( search_array )
    search = search_array.map { | name | "%#{ name }%" }
    Trip.where( "name LIKE ANY ( array[?] )", search ).to_a
  end

  def find_all_trips( search_array )
    name_trips = find_trips_by_names(search_array)
    tag_trips = find_trips_by_tags(search_array)
    ( name_trips + tag_trips ).uniq
  end

  def user_followed?( followed_user )
   Relationship.find_by( follower_id: current_user.id, followed_id: followed_user.id )
  end

  def users_following( user )
   Relationship.where( follower_id: user.id )
  end

  def trip_complete?( trip )
    trip.locations.length >= 3
  end

  def shuffle_trips(recommended_trips, followed_trips)
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


  helper_method :mailbox, :conversation, :user_followed?, :users_following, :trip_complete, :shuffle_trips

  private

    def mailbox
      @mailbox ||= current_user.mailbox
    end

    def conversation
      @conversation ||= mailbox.conversations.find(params[:id])
    end


  protected

    protect_from_forgery with: :exception

  include ApplicationHelper
end
