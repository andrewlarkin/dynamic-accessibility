class AddTypeToCompletedTask < ActiveRecord::Migration
  def change
    add_column :completed_tasks, :type, :string
  end
end
