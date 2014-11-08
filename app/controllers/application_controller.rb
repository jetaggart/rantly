class ApplicationController < ActionController::Base
  protect_from_forgery :with => :exception

  def current_user
    @_current_user ||= find_current_user
  end
  helper_method :current_user

  def current_admin
    @_current_admin ||= find_current_admin
  end
  helper_method :current_admin

  private

  def find_current_user
    User.find_by(:id => session[:user_id])
  end

  def find_current_admin
    User.find_by(:id => session[:admin_id], :admin => true)
  end
end
