class LocationsController < ApplicationController

  def index
    @trip = Trip.find_by( id: params[ :trip_id ] )
    @locations = @trip.locations
  end

  def new
    @trip = Trip.find_by( id: params[ :trip_id ] )

    if @trip == nil
      redirect_to error_path
    else
      if @trip.locations.length >= 1
        @locations = @trip.locations
      end

      if @trip.trip_complete?
        redirect_to error_path
      else
        if !user_signed_in?
          redirect_to root_path
        end
      end
    end
  end

  def create
    @location = Location.create( location_params )
    @trip = Trip.find_by( id: params[ :trip_id ])
    @trip.locations.push( @location )

    if request.xhr?
      render '_location_card', layout: false, locals: { location: @location, trip: @trip }
    end
  end

  def update
    @location = Location.find_by( id: params[ :id ] )
    @location.update_attributes( update_params )
    @trip = Trip.find_by( id: params[ :trip_id ] )

    if request.xhr?
      render '_location_card_success', layout: false, locals: { location: @location, trip: @trip }
    end
  end

  def coordinates
    trip = Trip.find_by( id: params[ :id ] )
    place = GOOGLE_CLIENT.spots_by_query( "#{trip.city}, #{trip.state}" )
    @coordinates = [ place.first.lat, place.first.lng ]

    if request.xhr?
      render partial: 'trips/coordinates', layout: false, locals: { coordinates: @coordinates }
    end
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
