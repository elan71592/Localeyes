class FavoritesController < ApplicationController

  def create
    @favorite = Favorite.create(user_id: current_user.id, trip_id: params[:trip])
    @trip = Trip.find_by(id: params[:trip])
    if request.xhr?
      render 'trips/_unfavorite', layout: false, locals: {trip: @trip}
    else
      redirect_to trip_path(@trip)
    end
  end

  def destroy
    @favorite = Favorite.find_by(id: params[:id])
    @trip = Trip.find_by(id: params[:trip_id])
    @favorite.destroy

    redirect_to trip_path(@trip)
  end
end
