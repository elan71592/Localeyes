class UsersController < ApplicationController
  def show
    @user = User.find_by( id: params[ :id ] )

    if !user_signed_in?
      redirect_to new_user_registration_path
    end

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
        if !@user.attended_trips.include?( trip ) && trip.creator != @user
          @common_trips << trip
        end
      end
    end

    @followed_users = []
    users_following(@user).each do |user|
      @followed_users << User.find_by(id: user.followed_id)
    end
    followed_trips = []
      @followed_users.each do |user|
        followed_trips << user.trips
      end

    @followed_trips = followed_trips
    @dashboard_trips = shuffle_trips(@common_trips, @followed_trips)
  end

  def edit
    @user = User.find( params[ :id ] )
  end

  def update
    @user = User.find_by( id: params[ :id ] )
    @user.update_attributes( update_params )

    if params[ :user ][ :picture ] != nil
      uploaded_io = params[ :user ][ :picture ]
      file = File.open( Rails.root.join('public', 'uploads', uploaded_io.original_filename ), 'wb' ) do |file|
        file.write( uploaded_io.read )
      end
      @user.update_attributes( picture_url: upload_pic( uploaded_io.original_filename ) )
    end
    redirect_to user_path(@user)
  end

  private


  def update_params
    params.require(:user).permit( :first_name, :last_name, :location, :email, :available, :bio, :allow_messages)
  end
end
