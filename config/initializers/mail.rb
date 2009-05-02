ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.raise_delivery_errors = true
ActionMailer::Base.smtp_settings = {
    :address => "mail.mmurthy.com",
    :port => 26,
    :domain => "www.mmurthy.com",
    :authentication => :login,
    :user_name => "mahesh+mmurthy.com",
    :password => "gotIt123"
}
