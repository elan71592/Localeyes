class UsersController < ApplicationController
  def show
    @user = User.find_by( id: params[ :id ] )

    if @user == nil
      redirect_to error_path
    else
      if !user_signed_in?
        redirect_to new_user_registration_path
      end

      @common_trips = @user.common_trips
      @followers = @user.followers
      @followed_users = @user.followed
      @followed_trips = @user.get_followed_trips
      @dashboard_trips = Trip.shuffle_trips( @common_trips, @followed_trips ).flatten
    end
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
