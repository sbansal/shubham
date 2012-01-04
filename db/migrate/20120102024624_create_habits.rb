class CreateHabits < ActiveRecord::Migration
  def change
    create_table :habits do |t|
      t.text :title
      t.integer :user_id

      t.timestamps
    end
  end
end
