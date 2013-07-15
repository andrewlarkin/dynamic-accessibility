class CreateParticipants < ActiveRecord::Migration
  def change
    create_table :participants do |t|
      t.string :email
      t.string :disability
      t.string :tech_ability
      t.string :device
      t.string :username
      t.string :password
      t.integer :prof_level

      t.timestamps
    end
  end
end
