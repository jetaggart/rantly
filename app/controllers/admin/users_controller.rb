module Admin
  class UsersController < AdminRequiredController
    def index
      @users = User.all
    end
  end
end