class Admin::UsersController < AdminController

  # GET admin/users
  def index
    @users = User.all
  end

end
