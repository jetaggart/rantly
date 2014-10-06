class FollowingsController < SignInRequiredController
  def create
    other_user = User.find(params[:following_id])

    Following.create!(:follower  => current_user,
                      :following => other_user)

    redirect_to :back, :notice => "You are now following #{other_user.full_name}"
  end

  def index
    @following = current_user.following
  end
end