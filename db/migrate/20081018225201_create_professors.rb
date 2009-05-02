class CreateProfessors < ActiveRecord::Migration
  def self.up
    create_table :professors do |t|
      t.string :firstName
      t.string :lastName
      t.string :department
      t.references :college

      t.timestamps
    end
  end

  def self.down
    drop_table :professors
  end
end
