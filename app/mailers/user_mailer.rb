class UserMailer < ActionMailer::Base
  
  def welcome_email(fullname, email)
    @fullname = fullname
    mail to: email, subject: "Welcome to Tracely", from: "support@hautworks.com"
  end
  
  def reminder_email(id)
    @user = User.find(id)
    @tasks = @user.tasks.order('created_at DESC').incomplete
    @habits = @user.habits.order('created_at DESC')
    if @user.send_daily_email?
      mail to: @user.email, subject: "Your Todo List and Habits for today", from: "support@hautworks.com"
    end
  end
end
