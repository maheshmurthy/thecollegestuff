class UserMailer < ActionMailer::Base
  def signup_notification(user)
    setup_email(user)
    @subject    += 'Please activate your new account'
    url = AppConfig.root_url  
    @body[:url]  =  "#{url}/activate/#{user.activation_code}" 
  end
 
  def activation(user)
    setup_email(user)
    @subject    += 'Your account has been activated!'
    @body[:url]  = AppConfig.root_url
  end

  def forgot_password(user)
    setup_email(user)
    @subject    += 'You have requested to change your password'
    url = AppConfig.root_url  
    @body[:url]  = "#{url}/reset_password/#{user.password_reset_code}" 
  end

  def reset_password(user)
    setup_email(user)
    @subject    += 'Your password has been reset.'
  end
  
  protected
    def setup_email(user)
      logger.info("Email was setup"); 
      @recipients  = "#{user.email}"
      @from        = AppConfig.from_address 
      @subject     = ""
      @sent_on     = Time.now
      @body[:user] = user
    end
end
