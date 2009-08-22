class Event < ActiveRecord::Base
  validates_presence_of :label, :name, :description, :date
  
  validates_length_of :label, :maximum => 20
  validates_length_of :name, :maximum => 50
  
  validates_uniqueness_of :label
end
