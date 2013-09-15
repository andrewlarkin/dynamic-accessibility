class AddColumnsToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :name, :string
    add_column :tasks, :is_active, :boolean
    add_column :tasks, :count, :integer
    add_column :tasks, :complete, :integer
    remove_column :tasks, :task_set_id
    remove_column :tasks, :description
    remove_column :tasks, :type
    drop_table :task_sets
  end
end
