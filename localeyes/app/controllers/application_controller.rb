class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

def google_client
  @client ||= GooglePlaces::Client.new( ENV[ 'GOOGLE_PLACES_KEY' ] )
end

 def sort_by_favorites(trip_list)
    trip_list.sort_by{|trip| trip.favorites.count}.reverse
 end

 def find_trips_by_tags(tag_array)
  tag_results = []
  tag_array.each {|name| tag_results << Tag.find_by(name: name)}
    if tag_results == [nil] || tag_results == nil
      trip_results = []
    else
      trip_results = tag_results.map{|tag| tag.trips if tag != nil}
    end
  trip_results
end

  protect_from_forgery with: :exception
  include ApplicationHelper
end
