class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  
  has_many :tasks
  has_many :habits
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, 
         :validatable, :email_regexp =>  /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i
         
  validates_uniqueness_of :email
  validates_presence_of :fullname, :email, :message => '*required field'

  # Setup accessible (or protected) attributes for your model
  # Make sure to add the attribute here in case of new field is added to user model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :fullname, :timezone
  
  def to_param
    "#{id}-#{fullname.gsub(/[^a-z0-9]+/i, '-')}"
  end
end
