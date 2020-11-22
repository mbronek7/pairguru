class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    comment = Comment.new(comment_params.merge!(user_id: current_user.id, movie_id: movie.id))
    if comment.save
      redirect_to movie, notice: "Comment was created."
    else
      redirect_to movie, alert: "Could not create this comment, note that you can comment this movie only once, and body must be present"
    end
  end

  def destroy
    comment = current_user.comments.find_by(id: params[:id])
    if comment.present?
      comment.destroy
      redirect_to movie, notice: "Comment was deestroyed"
    else
      redirect_to movie, alert: "You can't destriy this comment"
    end
  end

  private

  def movie
    @movie ||= Movie.find(params[:movie_id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
