class CommentsController < ApplicationController
  def create
    commentable = User.find_by(:id => params[:user_id]) || Rant.find_by!(:id => params[:rant_id])

    commentable.comments.create!(
      allowed_params.merge(:author => current_user)
    )

    redirect_to commentable, :notice => "Comment posted"
  end

  private

  def allowed_params
    params.require(:comment).permit(:text)
  end
end
