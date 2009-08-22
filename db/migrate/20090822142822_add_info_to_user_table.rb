class AddInfoToUserTable < ActiveRecord::Migration
  def self.up
    add_column :users, :name, :string, :default => nil, :null => true
    add_column :users, :email, :string, :default => nil, :null => true
    add_column :users, :avatar_file_name, :string
    add_column :users, :avatar_content_type, :string
    add_column :users, :avatar_file_size, :integer
    add_column :users, :avatar_updated_at, :datetime
    add_column :users, :last_login_at, :datetime
  end

  def self.down
    remove_column :users, :last_login_at
    remove_column :users, :avatar_updated_at
    remove_column :users, :avatar_file_size
    remove_column :users, :avatar_content_type
    remove_column :users, :avatar_file_name
    remove_column :users, :email
    remove_column :users, :name
  end
end
