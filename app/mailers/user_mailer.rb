class UserMailer < ActionMailer::Base
  default from: "support@hautworks.com"
  
  def welcome_email(fullname, email)
    @fullname = fullname
    mail to: email, subject: "Welcome to Tracely"
  end
end
