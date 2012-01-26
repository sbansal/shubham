class AddReminderToUsers < ActiveRecord::Migration
  def change
    add_column :users, :send_daily_email, :boolean
  end
end
