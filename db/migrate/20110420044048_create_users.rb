class CreateUsers < ActiveRecord::Migration
  #Defines User table
  def self.up
    create_table :users do |t|
      t.string :name
      t.string :email
      t.timestamps
    end
  end

  #Drops user table
  def self.down
    drop_table :users
  end
end
