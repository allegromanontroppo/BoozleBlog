class RenameCanPostOnUsers < ActiveRecord::Migration
  def self.up
	  rename_column :users, :canpost, :can_post
  end

  def self.down
	  rename_column :users, :can_post, :canpost
  end
end
