class RemoveCompletedFromTasks < ActiveRecord::Migration
  def change
    remove_column :tasks, :complete
  end
end
