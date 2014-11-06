class CommentsController < ApplicationController
  def create
    rant = Rant.find(params[:rant_id])
    rant.comments.create!(
      allowed_params.merge(:author => current_user)
    )

    redirect_to rant, :notice => "Comment posted"
  end

  private

  def allowed_params
    params.require(:comment).permit(:text)
  end
end