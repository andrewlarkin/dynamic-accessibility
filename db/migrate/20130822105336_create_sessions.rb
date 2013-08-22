class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.integer :participant_id
      t.date :expires
      t.string :token
    end
  end
end
