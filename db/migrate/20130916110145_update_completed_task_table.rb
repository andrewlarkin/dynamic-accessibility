class UpdateCompletedTaskTable < ActiveRecord::Migration
  def change
    remove_column :completed_tasks, :completed
    add_column :completed_tasks, :error_rate, :integer
    add_column :completed_tasks, :activity_id, :integer
    remove_column :completed_tasks, :feedback
    add_column :completed_tasks, :subjective_rating, :integer
  end
end
