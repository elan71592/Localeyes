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
    country = params[:country]
    @trips_to_display = Trip.find_all_trips( search_array, city, state, country )
    if @trips_to_display != nil
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

    if @trip.save
      tags.each do |tag|
        if tag[0] == "#"
          new_tag = Tag.find_or_create_by( name: tag[ 1..-1 ] )
        else
          new_tag = Tag.find_or_create_by( name: tag )
        end

        @trip.tags << new_tag
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
      @creator_comments = @trip.comments.where( user_id: @trip.creator.id)
      @user_comments = @trip.comments - @creator_comments

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
