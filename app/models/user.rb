class User < ActiveRecord::Base
  has_and_belongs_to_many :events
  has_many :owned_events, :class_name => "Event", :foreign_key => "owner_id"
  
  acts_as_authentic do |c|
    def attributes_to_save # :doc:
      attrs_to_save = attributes.clone.delete_if do |k, v|
        [ :persistence_token, :perishable_token, :single_access_token, :login_count,
          :failed_login_count, :last_request_at, :current_login_at, :last_login_at, :current_login_ip, :last_login_ip, :created_at,
          :updated_at, :lock_version].include?(k.to_sym)
      end
    end
  end
  
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  
  validates_attachment_content_type :avatar, :content_type => ["image/jpeg", "image/png", "image/gif"]
  
  validates_presence_of :name, :email
end
