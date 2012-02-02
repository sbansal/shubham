class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  
  has_many :tasks
  has_many :habits
    
  after_create :send_sign_up_notification 
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, 
         :validatable, :email_regexp =>  /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i
         
  validates_uniqueness_of :email
  validates_presence_of :fullname, :email, :message => '*required field'

  # Setup accessible (or protected) attributes for your model
  # Make sure to add the attribute here in case of new field is added to user model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :fullname, :timezone, :send_daily_email
  
  def to_param
    "#{id}-#{fullname.strip.gsub(/[^a-z0-9]+/i, '-')}"
  end
  
  # Get the time at which the user should receive there reminder email
  # the time changes based on each users timezone
  # We are sending emails at 0600 hrs in each user's timezone
  def process_run_at_time
    Time.zone = self.timezone
    time_in_zone = (Time.zone.now + 1.day).beginning_of_day + 6.hours
    Rails.logger.info "Time in zone - " + time_in_zone.to_s
    time_to_run = time_in_zone.utc
  end
  
  # Same as process_run_at_time for the specified timezone
  def process_run_at_time_for_tz(timezone)
    Time.zone = timezone
    time_in_zone = (Time.zone.now + 1.day).beginning_of_day + 6.hours
    Rails.logger.info "Time in zone - " + time_in_zone.to_s
    time_to_run = time_in_zone.utc
  end
  
  # send email reminders to everyone
  def self.send_email_reminder_to_all
    User.includes(:tasks, :habits).each do |user|
      user.send_email_reminder
    end
  end
  
  # send email reminders to people that have email reminder feature turned on
  def self.send_reminder_emails
    users = User.where(send_daily_email: true).includes(:tasks, :habits)
    users.each do |user|
      user.send_email_reminder
    end
  end
  
  def send_email_reminder
    UserMailer.delay(queue: "reminder_email", priority: 10, run_at: process_run_at_time).reminder_email(self.id)
  end
  
  def send_email_reminder_now
    UserMailer.delay(queue: "reminder_email", priority: 10).reminder_email(self.id)
  end
  
  
  private 
  def send_sign_up_notification
    #Resque.enqueue(WelcomeEmailWorker, self.id)
    # UserMailer.welcome_email(self.fullname, self.email).deliver
    UserMailer.delay(queue: "welcome_email", priority: -1).welcome_email(self.fullname, self.email)
  end
end
