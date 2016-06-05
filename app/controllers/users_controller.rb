class UsersController < ApplicationController
  def show
    @user = User.find_by(id: params[:id])
    @common_interests = []
    @common_trips = []

    tag_name = []

    @user.trips.each do | trip |
      trip.tags.each do | tag |
        @common_interests << tag if !tag_name.include? tag.name
        tag_name << tag.name
      end
    end

    @common_interests.each do | tag |
      tag.trips.each do | trip |
        if !@user.attended_trips.include?(trip) && trip.creator != @user
          @common_trips << trip
        end
      end
    end
  end

  def edit
    @user = User.find(params[:id])
  end
end
