class AddLoginToRatings < ActiveRecord::Migration
  def self.up
    add_column :ratings, :login, :string
  end

  def self.down
    remove_column :ratings, :login
  end
end
