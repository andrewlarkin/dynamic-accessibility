class AddPrereqToTask < ActiveRecord::Migration
  def change
    add_column :tasks, :prereq_id, :integer
  end
end
