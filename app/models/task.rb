class Task < ActiveRecord::Base
  
  scope :complete, where(:complete => '1')
  scope :incomplete, where(:complete => '0')
end
