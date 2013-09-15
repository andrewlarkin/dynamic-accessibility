class AddConsentToParticipant < ActiveRecord::Migration
  def change
    add_column :participants, :consent, :boolean
  end
end
