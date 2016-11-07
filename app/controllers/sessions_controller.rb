class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      #log_in function is defined in the sessions helper
      log_in user
      #Remember(user) and forget(user) are defined in the sessions_helper,
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_to user
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    # log_out is defined in the sessoions_helper
    log_out if logged_in?
    redirect_to root_url

  end
end
