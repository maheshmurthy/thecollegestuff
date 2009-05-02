class CreateRatings < ActiveRecord::Migration
  def self.up
    create_table :ratings do |t|
      t.references :college
      t.references :professor
      t.integer :q1
      t.integer :q2
      t.integer :q3
      t.integer :q4
      t.integer :q5
      t.float :avg
      t.boolean :pending
      t.string :comments

      t.timestamps
    end
  end

  def self.down
    drop_table :ratings
  end
end
