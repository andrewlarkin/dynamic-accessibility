class AddLastRequestAtToParticipants < ActiveRecord::Migration
  def change
    add_column :participants, :last_request_at, :datetime
  end
end
