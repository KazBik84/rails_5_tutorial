module SessionsHelper
  #logs in the given user.
  def log_in(user)
    session[:user_id] = user.id
  end

  # returns the current logged-in user (if any).
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(:remember, cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  def current_user?(user)
    user == current_user
  end


  #returns true if the user is logged in, false othervise
  def logged_in?
    !current_user.nil?
  end

  # logs out the current user
  def log_out
    #forget is a method in this helper
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

  #Remembers a user in a persistent session.
  def remember(user)
    #User.remember function is defined in the user model
    user.remember
    # '.permanent' - creates cookie valid for 20 years from creation.
    # '.signed' - encrypts a user.id
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end


  #Forgets the persistant session.
  def forget(user)
    #user.forget is defined in the User model
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  #Redirect to the stored location or default
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  #Stores the URL trying to be accessed
  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end
end



