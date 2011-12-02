class AddAdminToUsers < ActiveRecord::Migration
  #Sets up admin in DB
  def self.up
    add_column :users, :admin, :boolean, :default => false
  end

  def self.down
    remove_column :users, :admin
  end
end
