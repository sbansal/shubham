class CreateBasketizations < ActiveRecord::Migration
  def change
    create_table :basketizations do |t|
      t.integer :task_id
      t.integer :basket_id

      t.timestamps
    end
  end
end
