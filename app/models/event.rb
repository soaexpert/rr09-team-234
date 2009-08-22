class Event < ActiveRecord::Base
  # validates_presence_of :label, :name, :description, :date
  
  validates_length_of :label, :maximum => 20
  validates_length_of :name, :maximum => 50
  
  validates_uniqueness_of :label
  
  has_attached_file :logo, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  
  validates_attachment_content_type :logo, :content_type => ["image/jpeg", "image/png", "image/gif"]
  validates_attachment_presence :logo
  
  validates_presence_of :address, :label, :name
  
  validate :validates_address_is_valid
  
  private
    def validates_address_is_valid
      result = Geocoding::get(address)
      errors.add("address", "must be valid") unless result.status == Geocoding::GEO_SUCCESS && result.size == 1
    end
end
