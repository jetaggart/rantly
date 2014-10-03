class DashboardsController < SignInRequiredController
  def show
    @my_rants = current_user.rants
  end
end
