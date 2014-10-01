class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(allowed_params)

    @user.save!
    redirect_to root_path, :notice => "Thank you for registering"
  end


  private

  def allowed_params
    params.require(:user).permit(:username, :password,
                                 :first_name, :last_name,
                                 :bio, :type_of_ranter)
  end
  
end
