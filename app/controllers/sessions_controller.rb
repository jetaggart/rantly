class SessionsController < ApplicationController
  def new
    @session = UserSession.new(:session => session)
  end

  def create
    @session = UserSession.new(allowed_params.merge(:session => session))

    if @session.save
      redirect_to dashboard_path, :notice => "Welcome, #{@session.user.username}"
    else
      flash.now.alert = "Invalid username or password"
      render :new
    end
  end

  def destroy
    reset_session

    redirect_to root_path, :notice => "Logged out successfully"
  end

  private

  def allowed_params
    params.require(:user_session).permit(:username, :password)
  end
end
