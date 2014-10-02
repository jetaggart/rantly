class SignInRequiredController < ApplicationController
  before_action :ensure_logged_in_user

  private

  def ensure_logged_in_user
    unless current_user
      redirect_to root_path, :alert => "You're not allowed to access that page. Please sign up to continue."
    end
  end
end
