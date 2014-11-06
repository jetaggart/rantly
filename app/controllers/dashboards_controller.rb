class DashboardsController < SignInRequiredController
  def show
    @dashboard = Dashboard.new(current_user)
  end
end
