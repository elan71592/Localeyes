class FollowersController < ApplicationController
  def create
    Relationship.create( follow_params )
    if request.xhr?
      render partial: 'unfollow', layout: false, locals: { followed_id: params[ :follow ][ :followed_id ] }
    end
  end

  def destroy
    @followed_user = User.find_by( id: params[ :unfollow ][ :followed_id ] )
    @relationship = Relationship.find_by( follower_id: params[ :unfollow ][ :follower_id ], followed_id: params[ :unfollow ][ :followed_id ] )
    @relationship.destroy
    if request.xhr?
      render partial: '/followers/follow', layout: false, locals: { followed_id: @followed_user.id }
    end
  end

  private
    def follow_params
      params.require( :follow ).permit( :follower_id, :followed_id )
    end
end
