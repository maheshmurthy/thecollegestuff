class AddReviewToProfessor < ActiveRecord::Migration
  def self.up
    add_column :professors, :review, :boolean
  end

  def self.down
    remove_column :professors, :review
  end
end
