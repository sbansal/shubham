class WelcomeEmailWorker
  
  def self.queue
    :welcome_email_queue
  end

  
  def self.perform(user_id)
    user = User.find(user_id)
    UserMailer.welcome_email(user.fullname, user.email).deliver
  end
end