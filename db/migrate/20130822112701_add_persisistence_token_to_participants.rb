class AddPersisistenceTokenToParticipants < ActiveRecord::Migration
  def change
    add_column :participants, :persistence_token, :string
  end
end
