class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.string :label, :limit => 20
      t.string :name,  :limit => 50
      t.text :description
      t.integer :hits
      t.datetime :date
      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
