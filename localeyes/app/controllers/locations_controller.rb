class LocationsController < ApplicationController

  def new
    @key = ENV["GOOGLE_MAPS_KEY"]
  end

  def create
    @location = Location.create(location_params)
    @trip = Trip.find_by(id: params[:trip_id])
    @trip.locations.push(@location)
    if request.xhr?
      render '_location_card', layout: false, locals: { location: @location, trip: @trip }
      # Respond with a partial of the location card that a user can add a note and duration
    else

    end
  end

  def update
    @location = Location.find_by( id: params[ :id ] )
    @location.update_attributes( update_params )
    @trip = Trip.find_by( id: params[ :trip_id ] )
    if request.xhr?
      render '_location_card_success', layout: false, locals: { location: @location, trip: @trip }
    end
    # redirect_to new_trip_location_path( @trip )
  end

  def destroy
    @location = Location.find_by(id: params[:id])
    @location.destroy

    if request.xhr?
      render '_destroy', layout: false
    end
  end

  private

    def location_params
      params.require( :place ).permit( :name, :address, :phone_number, :website_url, :latitude, :longitude )
    end

    def update_params
      params.require( :location ).permit( :personal_note, :duration )
    end
end
