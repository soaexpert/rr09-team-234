include Geokit::Geocoders

class Event < ActiveRecord::Base
  acts_as_mappable :auto_geocode=>{:field=>:address, :error_message=>'Could not geocode address'}
  
  has_and_belongs_to_many :users
  has_many :approved_comments, :class_name => "Comment", :foreign_key => "event_id", :conditions => "approved = true", :order => "created_at DESC"
  has_many :unapproved_comments, :class_name => "Comment", :foreign_key => "event_id", :conditions => "approved = false", :order => "created_at DESC"
  belongs_to :owner, :class_name => "User"
  
  validates_length_of :label, :maximum => 20
  validates_length_of :name, :maximum => 50
  
  validates_uniqueness_of :label
  
  has_attached_file :logo, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  
  validates_attachment_content_type :logo, :content_type => ["image/jpeg", "image/png", "image/gif"]
  validates_attachment_presence :logo
  
  validates_presence_of :address, :label, :name, :date
  
  #Ultrasphinx
  is_indexed :fields => ['address', 'label', 'name'] , :delta => {:field => 'created_at'}
  
end
