class CommentsController < ApplicationController
  def new
    @comment = Comment.new
    @trip = Trip.find_by( id: params[ :trip_id ] )

    if request.xhr?
      render partial: "new_comment_form", layout: false, locals: { comment: @comment, trip: @trip }
    end
  end

  def create
    @comment = Comment.new( comment_params )
    @trip = Trip.find_by( id: params[ :comment ][ :trip_id ] )

    if @comment.save
      if request.xhr?
        render partial: "new_comment", layout: false, locals: { comment: @comment, trip: @trip }
      else
        redirect_to trip_path( @trip )
      end
    else
      render "new"
    end
  end

  # PANSAMPANSAM
  # Any protections in your edit update and destroy to prevent
  # a user from changing another user's trips?
  def edit
    @comment = Comment.find_by(id: params[:id])
    @trip = @comment.trip
  end

  def update
    @trip = Trip.find_by(id: params[:comment][:trip_id])
    @comment = Comment.find_by(id: params[:id])

    if @comment.update(comment_params)
      redirect_to trip_path(@trip)
    else
      render 'edit'
    end
  end

  def destroy
    @trip = Trip.find_by(id: params[:trip_id])
    @comment = Comment.find_by(id: params[:id])
    @comment.destroy

    if request.xhr?
      render partial: "delete_response"
    else
      redirect_to trip_path(@trip)
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:body, :trip_id, :user_id)
    end
end
