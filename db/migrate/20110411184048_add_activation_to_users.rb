class AddActivationToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :activated, :string, :default => 'Pending'
  end

  def self.down
    remove_column :users, :activated
  end
end
