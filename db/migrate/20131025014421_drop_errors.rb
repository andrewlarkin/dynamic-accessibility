class DropErrors < ActiveRecord::Migration
  def change
    drop_table :errors
  end
end
