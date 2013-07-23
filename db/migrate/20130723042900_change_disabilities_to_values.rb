class ChangeDisabilitiesToValues < ActiveRecord::Migration
  def change
    change_table :participants do |t|
      t.remove :disability
      t.boolean :is_deaf, :default => false
      t.boolean :is_hard_of_hearing, :default => false
      t.boolean :is_blind, :default => false
      t.boolean :is_low_vision, :default => false
      t.boolean :is_color_blind, :default => false
      t.boolean :is_limited_mobility, :default => false
      t.boolean :is_other_disability, :default => false
    end
  end
end
