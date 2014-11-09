class SessionsController < ApplicationController
  def new
    @session = UserSession.new(:session => session)
  end

  def create
    @session = UserSession.new(allowed_params.merge(:session => session))

    if @session.save
      Event.publish(:logins, :username => @session.user.username)
      redirect_to user_path, :notice => "Welcome, #{@session.user.username}"
    else
      flash.now.alert = @session.errors.full_messages.join(" ")
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

  def user_path
    if @session.user.admin?
      admin_dashboard_path
    else
      dashboard_path
    end
  end
end
