class AddLatLonColumn < ActiveRecord::Migration
  def self.up
    add_column :events, :lat, :float
    add_column :events, :lng, :float
  end

  def self.down
    remove_column :events, :lng
    remove_column :events, :lat
  end
end
