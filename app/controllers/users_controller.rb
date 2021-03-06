class UsersController < SignInRequiredController
  skip_before_action :ensure_logged_in_user,
                     :only => [:new, :create]

  def show
    @user = User.find(params[:id])
    @rants = @user.rants_by_favorites
  end

  def new
    @user = User.new
    render :new, :layout => "application"
  end

  def create
    @user = User.new(allowed_params)

    if @user.save
      ConfirmationMailer.confirmation_email(@user).deliver_now

      redirect_to root_path, :notice => "Thank you for registering"
    else
      render :new, :layout => "application"
    end
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
                                 :bio, :type_of_ranter, :image,
                                 :email)
  end
  
end
