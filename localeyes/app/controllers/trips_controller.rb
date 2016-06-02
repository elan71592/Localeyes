class TripsController < ApplicationController

def index
  @trips = Trip.all
end

def new
  @trip = Trip.new
end

def create
  @trip = Trip.new(trip_params)
    if @trip.save
      redirect_to trip
    else
      render 'new'
    end
end

  def show
    @trip = Trip.find_by(id: params[:id])
  end

end
