class ApplicationController < ActionController::Base
  protect_from_forgery :with => :exception

  def current_user
    @_current_user ||= find_current_user
  end
  helper_method :current_user

  private

  def find_current_user
    User.find_by(:id => session[:user_id])
  end
end
