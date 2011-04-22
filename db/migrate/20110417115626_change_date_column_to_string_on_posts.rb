class ChangeDateColumnToStringOnPosts < ActiveRecord::Migration
  def self.up
	  change_column(:posts, :date, :string)
  end

  def self.down
	  change_column(:posts, :date, :date)
  end
end
