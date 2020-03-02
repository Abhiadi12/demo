class SessionController < ApplicationController
  def new
      redirect_to user_path(current_user) if is_login?
  end
  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id #set the session for the user
      redirect_to user_path(user)
    else
      flash.now[:danger] = "There was something wrong with your login information"
      render 'new'
    end
  end
    
  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end