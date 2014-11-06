class DashboardsController < SignInRequiredController
  def show
    redirect_to admin_dashboard_path if current_user.admin?

    @dashboard = Dashboard.new(current_user)
  end
end
