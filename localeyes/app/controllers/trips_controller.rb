class TripsController < ApplicationController

def index
  @trips = Trip.all
  @trips_to_display = sort_by_favorites(@trips)

  if params[:search]
   tag_array = params[:search].split(" ")
   @trips_to_display = find_trips_by_tags(tag_array)[0]
  end
end

def new
  @trip = Trip.new
end

def create
  @trip = Trip.new(trip_params)
    if @trip.save
      redirect_to new_trip_location_path(@trip)
    else
      render 'new'
    end
  # respond_to do |format|
  #     if @trip.save
  #       format.html { redirect_to @trip, notice: 'Trip was successfully created.' }
  #       format.json { render :show, status: :created, location: @trip }
  #     else
  #       format.html { render :new }
  #       format.json { render json: @trip.errors, status: :unprocessable_entity }
  #     end
  #   end
end

def show
  @trip = Trip.find_by(id: params[:id])
end

private
  def trip_params
    params.require(:trip).permit( :name )
  end
end
