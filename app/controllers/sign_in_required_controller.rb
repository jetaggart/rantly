class SignInRequiredController < ApplicationController
  before_action :ensure_logged_in_user

  layout "signed_in"

  private

  def ensure_logged_in_user
    return if current_user

    redirect_to(
      root_path,
      :alert => "You're not allowed to access that page. Please sign up to continue."
    )
  end
end
