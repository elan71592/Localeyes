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

  respond_to do |format|
      if @trip.save
        format.html { redirect_to @trip, notice: 'Trip was successfully created.' }
        format.json { render :show, status: :created, location: @trip }
      else
        format.html { render :new }
        format.json { render json: @trip.errors, status: :unprocessable_entity }
      end
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
