class Task < ActiveRecord::Base
  
  belongs_to :user
  has_many :basketization
  has_many :baskets, :through => :basketization
  
  before_create :check_duedate
  
  scope :complete, where(:complete => '1')
  scope :incomplete, where(:complete => '0')
  
  def check_duedate
    if self.duedate.nil?
      self.duedate = DateTime.now
    end
  end
  
  def self.search(search, current_user)
    if !search.nil?
      if ActiveRecord::Base.configurations[Rails.env]['adapter'] == 'mysql2'
        Rails.logger.info "Search mysql"
        Task.where(["name like ? AND user_id = ?", '%' + search + '%', current_user.id])
      elsif ActiveRecord::Base.configurations[Rails.env]['adapter'] == 'postgresql'
        Rails.logger.info "Search postgres"
        Task.where(["name ILIKE ? AND user_id = ?", '%' + search + '%', current_user.id])
      end
    else 
      current_user.tasks
    end
  end
end
