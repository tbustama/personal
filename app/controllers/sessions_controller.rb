class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email])
    if (user && user.authenticate(params[:password])) && (user.key == params[:key])
      session[:user_id] = user.id
      redirect_to new_post_path, notice: "Logged in!"
    else
      flash.now[:alert] = "Email or password is invalid"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path
  end
end
