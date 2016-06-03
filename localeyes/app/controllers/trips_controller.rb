class TripsController < ApplicationController

def index
  @trips = Trip.all
  @sorted_trips = sort_by_favorites(@trips)
end

def new
  @trip = Trip.new
end

def create
  @trip = Trip.new(trip_params)
    if @trip.save
      redirect_to trip_path( @trip )
    else
      render 'new'
    end
end

def show
  @trip = Trip.find_by(id: params[:id])
end

private
  def trip_params
    params.require(:trip).permit( :name, :tags )
  end
end
