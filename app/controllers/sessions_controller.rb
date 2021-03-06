class SessionsController < ApplicationController

  layout 'frontend/amaze/root/index'

  def new
  end

  def create
    user = User.find_by(login: params[:session][:login])
    if user && user.authenticate(params[:session][:password])
      log_in(user)
      redirect_to root_path
    else
      flash.now[:danger] = "Login lub hasło jest nie poprawne"
      render :new
    end
  end

  def destroy
    log_out
    redirect_to root_path
  end

end
