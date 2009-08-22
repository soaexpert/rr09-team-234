class EventsController < ApplicationController
  # before_filter :require_login, :only => [:new]
  
  def index
    @next_events = Event.find :all, 
                              :conditions => ["date >= ?", Time.now], 
                              :order => "date ASC", 
                              :limit => 5
                              
    @past_events = Event.find :all, 
                              :conditions => ["date < ?", Time.now], 
                              :order => "date DESC",
                              :limit => 5
                              
    @close_events = []
                              
    @user_session = UserSession.new
  end
  
  def new
    @event = Event.new
    
    @next_events = Event.find :all, 
                              :conditions => ["date >= ?", Time.now], 
                              :order => "date ASC", 
                              :limit => 5
                              
    @past_events = Event.find :all, 
                              :conditions => ["date < ?", Time.now], 
                              :order => "date DESC",
                              :limit => 5
                              
    @close_events = []
  end
  
  def create
    @event = Event.new(params[:event])
    # @event.owner = current_user
    
    if @event.save
      flash[:notice] = "Event created"
      redirect_to root_url
    else
      flash[:notice] = "Evente creation failed"
      render :new
    end
  end
  
  def show
    @event = Event.find(params[:id])
    @comment = Comment.new
    
    begin
      @photos = Flickr.new.photos(:tags => "fms_#{@event.label}", :per_page => '10')
    rescue
      @photos = []
    end
  end
  
  def join
    @event = Event.find(params[:id])
    
    if current_user.nil?
      flash[:notice] = "You must be logged in"
    else
      @event.users << current_user
      @event.save
      flash[:notice] = "You were added"
    end
    redirect_to event_path(@event)
  end
  
  def unjoin
    @event = Event.find(params[:id])
    
    if current_user.nil?
      flash[:notice] = "You must be logged in"
    else
      @event.users = @event.users - current_user
      @event.save
      flash[:notice] = "You were removed"
    end
    redirect_to event_path(@event)
  end
end
