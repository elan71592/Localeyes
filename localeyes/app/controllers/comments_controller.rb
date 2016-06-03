class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @trip = Trip.find_by(id: params[:trip_id])
    if @item.save
      redirect_to trip_path(@trip)
    else
      redirect_to trip_path(@trip)
    end
  end

  def update
    @trip = Trip.find_by(id: params[:trip_id])
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

    if current_user != @comment.user
      @comment.destroy
      redirect_to trip_path(@trip)
    else
      redirect_to trip_path(@trip)
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:body, :trip_id, :user_id)
    end

end
