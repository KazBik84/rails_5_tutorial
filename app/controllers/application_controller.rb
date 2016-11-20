class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

private

  def logged_in_user
    #logged_in? is defined in the sessions helper
    unless logged_in?
      #store_location method is defined in the sessions_helper
      store_location
      flash[:danger] = 'Please log in.'
      redirect_to login_url
    end
  end
end
