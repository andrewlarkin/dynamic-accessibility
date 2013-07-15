class CreateCompletedTasks < ActiveRecord::Migration
  def change
    create_table :completed_tasks do |t|
      t.integer :rating
      t.string :feedback
      t.boolean :completed
      t.integer :time
      t.integer :success_rate
      t.integer :participant_id
      t.integer :task_id

      t.timestamps
    end
  end
end
