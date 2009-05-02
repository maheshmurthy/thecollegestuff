class AddShowNameToRatings < ActiveRecord::Migration
  def self.up
    add_column :ratings, :showname, :boolean
  end

  def self.down
    remove_column :ratings, :showname
  end
end
