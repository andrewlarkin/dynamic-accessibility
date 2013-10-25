class RemoveProfLevelFromParticipants < ActiveRecord::Migration
  def change
    remove_column :participants, :prof_level
  end
end
