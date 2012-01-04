class Habit < ActiveRecord::Base
  has_many :traces
  belongs_to :user

end
