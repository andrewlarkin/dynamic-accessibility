class RemoveRatingFromCompletedTasks < ActiveRecord::Migration
  def change
    remove_column :completed_tasks, :rating
  end
end
