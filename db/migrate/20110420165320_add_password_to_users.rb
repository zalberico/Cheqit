class AddPasswordToUsers < ActiveRecord::Migration
  #Adds an encrypted password to database
  def self.up
    add_column :users, :encrypted_password, :string
  end

  def self.down
    remove_column :users, :encrypted_password
  end
end
