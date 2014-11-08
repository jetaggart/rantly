module Admin
  class ImpersonationsController < AdminRequiredController

    def create
      session[:user_id] = params[:user_id]
      redirect_to dashboard_path
    end

    def destroy
      session[:user_id] = nil
      redirect_to admin_dashboard_path
    end

  end
end
