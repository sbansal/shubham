class CreateTraces < ActiveRecord::Migration
  def change
    create_table :traces do |t|
      t.integer :habit_id
      t.datetime :trace_date
      t.boolean :trace_complete

      t.timestamps
    end
  end
end
