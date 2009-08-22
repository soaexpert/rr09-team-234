class EventsController < ApplicationController
  def index
    @next_events = Event.find :all, 
                              :conditions => ["date >= ?", Time.now], 
                              :order => "date ASC", 
                              :limit => 7
                              
    @past_events = Event.find :all, 
                              :conditions => ["date < ?", Time.now], 
                              :order => "date DESC",
                              :limit => 7
  end
end
