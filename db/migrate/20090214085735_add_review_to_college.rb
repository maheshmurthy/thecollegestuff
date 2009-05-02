class AddReviewToCollege < ActiveRecord::Migration
  def self.up
    add_column :colleges, :review, :boolean
  end

  def self.down
    remove_column :colleges, :review
  end
end
