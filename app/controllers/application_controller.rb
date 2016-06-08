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
