class ConfirmationsController < ApplicationController
  def create
    user = User.find_by!(:confirmation_token => params[:token])

    user.update!(:confirmation_token => nil)

    redirect_to new_session_path, :notice => "Your account has been confirmed. Please log in."
  end
end
