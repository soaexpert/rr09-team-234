class AddLocalColumnToEvent < ActiveRecord::Migration
  def self.up
    add_column :events, :address, :string
  end

  def self.down
    remove_column :events, :address
  end
end
