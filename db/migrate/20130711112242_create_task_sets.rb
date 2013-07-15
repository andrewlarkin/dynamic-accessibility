class CreateTaskSets < ActiveRecord::Migration
  def change
    create_table :task_sets do |t|
      t.string :name
      t.string :is_active

      t.timestamps
    end
  end
end
