class UsersController < ApplicationController
  def show
    @user = User.find_by( id: params[ :id ] )
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
      params.require( :user ).permit( :first_name, :last_name, :location, :email, :available, :allow_messages )
    end
end
