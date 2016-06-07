class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  def google_client
    @client ||= GooglePlaces::Client.new( ENV[ 'GOOGLE_PLACES_KEY' ] )
  end

  def upload_pic( image )
    auth = {
      cloud_name: "localeyes-trips",
      api_key:    ENV[ "CLOUDINARY_KEY" ],
      api_secret: ENV[ "CLOUDINARY_SECRET" ]
    }

    image = Cloudinary::Uploader.upload( Rails.root.join( 'public', 'uploads', image ), auth )
    image[ 'url' ]
  end

  def sort_by_favorites( trip_list )
    trip_list.sort_by{|trip| trip.favorites.count}.reverse
  end

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

  helper_method :mailbox, :conversation, :user_followed?, :users_following

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
