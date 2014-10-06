class FollowingsController < SignInRequiredController
  def create
    other_user = User.find(params[:following_id])

    Following.create!(:follower  => current_user,
                      :following => other_user)

    redirect_to :back, :notice => "You are now following #{other_user.full_name}"
  end

  def index
    @following_users = current_user.following_users
  end

  def destroy
    following = Following.find(params[:id])
    following.destroy!
    redirect_to :back, :notice => "You are no longer following #{following.following.full_name}"
  end
end