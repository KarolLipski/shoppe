class Admin::UsersController < AdminController

  # GET admin/users
  def index
    @users = User.all
  end

  #GET admin/users/:id/edit
  def edit
    @user = User.find(params[:id])
  end

  #GET admin/users/new
  def new
    @user = User.new
  end

  #POST admin/users
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:succes] = 'KLient został dodany'
      redirect_to admin_users_path
    else
      flash[:danger] = 'Błąd zapisu'
      render :new
    end
  end

  #PUT admin/users/:id
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = 'Dane użytkownika zostały zmienione'
      redirect_to admin_users_path
    else
      flash[:danger] = 'Błąd zapisu'
      render :edit
    end
  end

  def user_params
    params.require(:user).permit(:name, :contractor_sym, :reciver_sym, :email, :login,
      :password, :password_confirmation)
  end

end
