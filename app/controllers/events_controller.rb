class EventsController < ApplicationController
  before_filter :require_login, :only => [:new]
  
  def index
    @next_events = Event.find :all, 
                              :conditions => ["date >= ?", Time.now], 
                              :order => "date ASC", 
                              :limit => 7
                              
    @past_events = Event.find :all, 
                              :conditions => ["date < ?", Time.now], 
                              :order => "date DESC",
                              :limit => 7
                              
    @user_session = UserSession.new
  end
  
  def new
    @event = Event.new
  end
end
