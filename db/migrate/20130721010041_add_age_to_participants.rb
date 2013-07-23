class AddAgeToParticipants < ActiveRecord::Migration
  def change
    add_column :participants, :age, :string
  end
end
