class Admin::UsersController < AdminController

  # GET admin/users
  def index
    @users = User.all
  end

  #GET admin/users/:id/edit
  def edit
    @user = User.find(params[:id])
  end

  #PUT admin/users/:id
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = 'Dane użytkownika zostały zmienione'
      redirect_to admin_users_path
    else
      render :edit
    end
  end

  def user_params
    params.require(:user).permit(:name, :contractor_sym, :reciver_sym, :email, :login,
      :password, :password_confirmation)
  end

end
