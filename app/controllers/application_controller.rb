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
  image = Cloudinary::Uploader.upload(Rails.root.join('public', 'uploads', image), auth)
  image[ 'url' ]
end

 def sort_by_favorites(trip_list)
    trip_list.sort_by{|trip| trip.favorites.count}.reverse
 end

 def find_trips_by_tags(search_array)
  tag_results = []
  search_array.each {|name| tag_results << Tag.find_by(name: name.downcase)}
    if tag_results == [nil] || tag_results == nil
      trip_results = []
    else
      trip_results = tag_results.map{|tag| tag.trips if tag != nil}
    end
  trip_results
end

def find_trips_by_names(search_array)
  name_results = []
  search_array.each {|name| name_results << Trip.where("lower(name) like ?", "%" + name.downcase + "%")}
  name_results
end

def find_all_trips(search_array)
  name_trips = find_trips_by_names(search_array)[0]
  tag_trips = find_trips_by_tags(search_array)[0]
    if name_trips != nil && tag_trips != nil
      all_trips = name_trips + tag_trips
      all_trips.uniq
    elsif name_trips != nil && tag_trips == nil
      all_trips = name_trips
    elsif name_trips == nil && tag_trips != nil
      all_trips = tag_trips
    else
      all_trips = []
    end
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
