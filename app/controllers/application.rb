# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base

  include AuthenticatedSystem
  include SimpleCaptcha::ControllerHelpers

  helper :all # include all helpers, all the time
  helper :prototype_window_class

  session :session_key => '_prof_ratings'
  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery  :secret => '856132e6ededba917c6a7cee8801504a'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password

  def redirect_to_login_page
    redirect_to :controller => 'session', :action => 'new'
  end
end
