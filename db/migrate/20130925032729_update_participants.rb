class UpdateParticipants < ActiveRecord::Migration
  def change
    remove_column :participants, :is_deaf
    remove_column :participants, :is_blind
    remove_column :participants, :is_hard_of_hearing
    remove_column :participants, :is_color_blind
    remove_column :participants, :is_low_vision
    remove_column :participants, :is_limited_mobility
    remove_column :participants, :is_other_disability
    add_column :participants, :group, :string
  end
end
