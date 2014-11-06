class FollowingsController < SignInRequiredController
  def create
    other_user = User.find(params[:following_id])

    Following.create!(:follower  => current_user,
                      :following => other_user)

    render :partial => "following", :locals => {:user => other_user}
  end

  def index
    @following_users = current_user.following_users
  end

  def destroy
    following = Following.find(params[:id])
    other_user = following.following

    following.destroy!
    render :partial => "following", :locals => {:user => other_user}
  end
end