class SessionsController < ApplicationController
  def new

  end

  def create
    user = User.find_by(name: params[:session][:login])
    if user && user.authenticate(params[:session][:password])
      redirect_to root_path
    else
      flash[:danger] = "Login lub hasło jest nie poprawne"
      render :new
    end
  end

end
