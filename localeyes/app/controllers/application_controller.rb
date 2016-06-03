class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

def google_client
  @client ||= GooglePlaces::Client.new( ENV[ 'GOOGLE_PLACES_KEY' ] )
end

 def sort_by_favorites(trip_list)
    trip_list.sort_by{|trip| trip.favorites.count}.reverse
  end

  protect_from_forgery with: :exception
  include ApplicationHelper
end
