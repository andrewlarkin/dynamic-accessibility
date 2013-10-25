class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.integer :participant_id
      t.string :type
      t.integer :score
    end
  end
end
