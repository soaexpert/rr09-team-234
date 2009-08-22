class Event < ActiveRecord::Base
  validates_presence_of :label, :name, :description, :date
  
  validates_length_of :label, :maximum => 20
  validates_length_of :name, :maximum => 50
  
  validates_uniqueness_of :label
  
  has_attached_file :logo, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  
  validates_attachment_content_type :logo, :content_type => ["image/pjpeg", "image/x-png"]
  
end
