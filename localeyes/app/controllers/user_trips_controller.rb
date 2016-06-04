class UserTripsController < ApplicationController
  def create
    @trip = Trip.find(params[:user_trip][:attended_trip_id])
    current_user.attend!(@trip)
    redirect_to trip_path(@trip)
  end

  def destroy
    @trip = UserTrip.find(params[:id]).attended_trip
    current_user.cancel!(@trip)
    redirect_to trip_path(@trip)
  end

end
