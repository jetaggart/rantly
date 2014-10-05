class DashboardsController < SignInRequiredController
  def show
    @my_rants = current_user.rants
    @latest_rants = Rant.latest_for(current_user)
  end
end
