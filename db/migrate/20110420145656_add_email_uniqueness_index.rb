class AddEmailUniquenessIndex < ActiveRecord::Migration
  #Ensures users have unique emails
  def self.up
    add_index :users, :email, :unique => true
  end

  def self.down
    remove_index :users, :email
  end
end
