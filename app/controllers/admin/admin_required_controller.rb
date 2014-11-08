module Admin
  class AdminRequiredController < ApplicationController
    layout "admin"

    before_action :ensure_logged_in_admin

    def ensure_logged_in_admin
      return if current_admin

      redirect_to(
        root_path,
        :alert => "You're not allowed to access that page."
      )
    end
  end
end
