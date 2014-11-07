module Admin
  class UsersController < AdminRequiredController
    def index
      @users = User
                .select("users.*, COUNT(rants.id) as rant_count")
                .joins("LEFT JOIN rants ON rants.author_id = users.id")
                .group("users.id")
                .order("rant_count #{params[:sort] || "DESC"}")
    end
  end
end
