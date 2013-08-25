class RenamePasswordToCryptedPasswordInParticipants < ActiveRecord::Migration
  def change
    rename_column :participants, :password, :crypted_password
  end
end
