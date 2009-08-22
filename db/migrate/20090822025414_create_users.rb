class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :openid_identifier
      t.timestamps
    end
    add_index :users, :openid_identifier
  end

  def self.down
    drop_table :users
  end
end
