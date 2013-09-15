class AddIsSelectedToParticipants < ActiveRecord::Migration
  def change
    add_column :participants, :is_selected, :boolean, { :default => false }
  end
end
