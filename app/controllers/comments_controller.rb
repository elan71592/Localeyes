class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @trip = Trip.find_by(id: params[:trip_id])
    respond_to do |format|
      if @comment.save
        format.html { redirect_to @comment, notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render action: "new" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
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

    @comment.destroy
    respond_to do |format|
      format.html { redirect_to comments_url, notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end

  end

  private
    def comment_params
      params.require(:comment).permit(:body, :trip_id, :user_id)
    end

end
