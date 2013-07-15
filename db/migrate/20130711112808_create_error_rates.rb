class CreateErrorRates < ActiveRecord::Migration
  def change
    create_table :error_rates do |t|
      t.integer :completed_task_id
      t.integer :error_id
      t.integer :error_count

      t.timestamps
    end
  end
end
