class AddHiddenToPosts < ActiveRecord::Migration
  def self.up
    add_column :posts, :hidden, :boolean, :default => false
  end
  
  def self.down
    remove_column :posts, :hidden
  end
end

