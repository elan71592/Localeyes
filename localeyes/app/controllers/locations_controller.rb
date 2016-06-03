class LocationsController < ApplicationController

  def new
  end

  def create
    @location = Location.create(location_params)
    @trip = Trip.find_by(id: params[:trip_id])
    @trip.locations.push(@location)
    if request.xhr?
      # Respond with a partial of the location card that a user can add a note and duration
    else

    end
    binding.pry
  end

  def destroy

  end

  private

    def location_params
      params.require( :place ).permit( :name, :address, :phone_number, :website_url )
    end
end
