class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :type
      t.string :description
      t.integer :task_set_id

      t.timestamps
    end
  end
end
