class ChangeTechAbilityInParticipants < ActiveRecord::Migration
  def change
    change_table :participants do |t|
      t.remove :tech_ability
      t.integer :tech_ability
    end
  end
end
