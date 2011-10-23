class CreateRelationships < ActiveRecord::Migration
  def self.up
    create_table :relationships do |t|
      t.integer :cheqer_id
      t.integer :cheqed_id
      #t.boolean :match #Added for matching

      t.timestamps
    end
    add_index :relationships, :cheqer_id
    add_index :relationships, :cheqed_id
    add_index :relationships, [:cheqer_id, :cheqed_id], :unique => true
  end

  def self.down
    drop_table :relationships
  end
end
