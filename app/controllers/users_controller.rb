class UsersController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead

  def sub_layout
    "users"
  end

  # render new.rhtml
  def new
    store_location
  end

  def create
    cookies.delete :auth_token
    # protects against session fixation attacks, wreaks havoc with 
    # request forgery protection.
    # uncomment at your own risk
    # reset_session
    @user = User.new(params[:user])
    begin
      @user.save
    rescue Exception => e
      redirect_back_or_default('/')
      logger.info e.to_s
      if (e.to_s.include? "550 No Such User Here") || (e.to_s.include? "recipient address must contain a domain")
        flash[:notice] = "Looks like the email id you have entered is invalid. Please correct it and try again."
      else
        flash[:notice] = "Oops! Something bad happened. Please notify the administrator"
      end
      return
    rescue
      flash[:notice] = "Oops! Something bad happened. Please notify the administrator"
    end
    if @user.errors.empty?
#      self.current_user = @user
      redirect_to ('/')
      flash[:notice] = "Thanks for signing up! Please check your email for activating your account."
    else
      render :action => 'new'
    end
  end

  def activate
    self.current_user = params[:activation_code].blank? ? false : User.find_by_activation_code(params[:activation_code])
    if logged_in? && !current_user.active?
      current_user.activate
      flash[:notice] = "Signup complete!"
    end
    redirect_back_or_default('/')
  end

  def forgot_password
    return unless request.post?
    logger.info "Came here"
    if @user = User.find_by_email(params[:user][:email])
      @user.forgot_password
      @user.save
      redirect_back_or_default('/')
      flash[:notice] = "A password reset link has been sent to your email address" 
    else
      flash[:notice] = "Could not find a user with that email address" 
    end
  end

  def reset_password
    @user = User.find_by_password_reset_code(params[:id])
    return if @user unless params[:user]

    if ((params[:user][:password] && params[:user][:password_confirmation]) && 
      !params[:user][:password_confirmation].blank?)
      self.current_user = @user #for the next two lines to work
      current_user.password_confirmation = params[:user][:password_confirmation]
      current_user.password = params[:user][:password]
      @user.reset_password
      flash[:notice] = current_user.save ? "Password reset success." : "Password reset failed." 
      redirect_back_or_default('/')
    else
      flash[:alert] = "Password mismatch" 
    end  
  end
end
