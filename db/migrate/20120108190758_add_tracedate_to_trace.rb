class AddTracedateToTrace < ActiveRecord::Migration
  def change
    add_column :traces, :tracedate, :date
  end
end
