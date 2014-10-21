class UsersController < SignInRequiredController

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(allowed_params)

    @user.save!
    redirect_to root_path, :notice => "Thank you for registering"
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    @user.update!(allowed_params)
    redirect_to dashboard_path, :notice => "Profile updated"
  end

  private

  def allowed_params
    params.require(:user).permit(:username, :password,
                                 :first_name, :last_name,
                                 :bio, :type_of_ranter)
  end
  
end
