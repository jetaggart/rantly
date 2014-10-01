class SessionsController < ApplicationController
  def new
    @session = UserSession.new
  end

  def create
    @session = UserSession.new(allowed_params.merge(:session => session))

    if @session.save
      redirect_to dashboard_path, :notice => "Welcome, #{@session.user.username}"
    else
      render :new, :alert => "Invalid username or password"
    end
  end

  private

  def allowed_params
    params.require(:user_session).permit(:username, :password)
  end
end
