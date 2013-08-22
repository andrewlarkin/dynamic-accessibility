class RemoveUsernameFromParticipants < ActiveRecord::Migration
  def change
    remove_column :participants, :username, :string
  end
end
