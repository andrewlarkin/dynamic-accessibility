class RenameType < ActiveRecord::Migration
  def change
    remove_column :completed_tasks, :type
    add_column :completed_tasks, :activity_type, :string

    remove_column :scores, :type
    add_column :scores, :activity_type, :string
  end
end
