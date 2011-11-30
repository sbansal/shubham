class AddDuedateToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :duedate, :datetime
    
    #set the default due date as the created date
    execute "UPDATE TASKS SET duedate = created_at"
  end
end
