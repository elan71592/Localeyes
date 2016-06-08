class TripsController < ApplicationController

  def index
    @trips_to_display = Trip.sort_by_favorites
    @search_results = false
    @trip = Trip.new
  end

  def search
    search_array = params[:search].split(" ")
    city = params[:city]
    state = params[:state]
    country = params[:trip][:country]
    if params[:city] == "" && params[:state] == "" && params[:trips][:country] == ""
      @trips_to_display = Trip.find_trips_by_names_tags(search_array)
    else
      @trips_to_display = Trip.find_all_trips(search_array, city, state, country)
    end
    if @trips_to_display != []
      @search_results = true
    end
    render :template => 'trips/index'
  end

  def new
    @trip = Trip.new
    if !user_signed_in?
      redirect_to root_path
    end
  end

  def create
    @trip = Trip.new(trip_params)
    @trip.creator = current_user
    if params[ :trip ][ :tags ].include?( ", " )
      tags = params[ :trip ][ :tags ].split( ", " )
    else
      tags = params[ :trip ][ :tags ].split( " " )
    end
    tags = Tag.split_tags(params[ :trip ][ :tags ])

    if @trip.save
      tags.each do |tag|
        @trip.tags << Tag.find_create_tags(tag)
      end

      if @trip.tags.length < 1
        @trip.destroy
        @errors = [ "Trip must have at least one tag.", "Please add one tag to continue." ]
        render 'new'
      else
        redirect_to new_trip_location_path( @trip )
      end
    else
      @errors = [ "Trip name cannot be blank.", "Please add a name to continue." ]
      render 'new'
    end
  end

  def show
    @trip = Trip.find_by( id: params[ :id ] )

    if @trip == nil
      redirect_to new_trip_path
    else
      @locations = @trip.locations
      @comment = Comment.new
      @creator_comments = @trip.creator_comments
      @user_comments = @trip.user_comments

      if @trip.locations.length < 3
        redirect_to new_trip_location_path( @trip )
      end
    end

  end

  def destroy
    @trip = Trip.find_by( id: params[ :id ] )
    @trip.destroy

    if request.xhr?
      render partial: "deleted_locations"
    end
  end

  private
    def trip_params
      params.require( :trip ).permit( :name, :city, :state, :country )
    end
end
