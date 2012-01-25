class AddIndexes < ActiveRecord::Migration
  def up
    add_index :tasks, :user_id
    # add_index :tasks, :name
    add_index :habits, :user_id
    add_index :basketizations, :task_id
    add_index :basketizations, :basket_id
    add_index :traces, :habit_id
  end

  def down
    remove_index :tasks, :user_id
    # remove_index :tasks, :name
    remove_index :habits, :user_id
    remove_index :basketizations, :task_id
    remove_index :basketizations, :basket_id
    remove_index :traces, :habit_id
  end
end
