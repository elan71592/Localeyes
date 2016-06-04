class UserTripsController < ApplicationController
  def create
    @trip = Trip.find(params[:user_trip][:attended_trip_id])
    current_user.attend!(@trip)

    if request.xhr?
      render 'trips/_cancel', layout: false, locals: {trip: @trip}
    else
      redirect_to trip_path(@trip)
    end
  end

  def destroy
    @trip = UserTrip.find(params[:id]).attended_trip
    current_user.cancel!(@trip)
    if request.xhr?
      render 'trips/_attend', layout: false, locals: {trip: @trip}
    else
      redirect_to trip_path(@trip)
    end
  end

end
