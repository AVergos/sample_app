class RenameEncryptedPassword < ActiveRecord::Migration
  def self.up
    rename_column :users, :encrypted_password, :crypted_password
  end

  def self.down
  end
end
