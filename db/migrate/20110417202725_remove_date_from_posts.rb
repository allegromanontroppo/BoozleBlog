class RemoveDateFromPosts < ActiveRecord::Migration
  def self.up
    remove_column :posts, :date
  end

  def self.down
    add_column :posts, :date, :string
  end
end
