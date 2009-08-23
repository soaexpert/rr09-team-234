class EventsController < ApplicationController
  before_filter :require_login, :except => [:index, :show]
  geocode_ip_address 
  
  def index
    @location = session[:geo_location]
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
    
    render :layout => 'home'
  end
  
  def new
    @location = session[:geo_location]
    
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
    render :layout => 'home'
  end
  
  def create
    @event = Event.new(params[:event])
    @event.owner = current_user
    
    if @event.save
      flash[:notice] = "Event created!"
      redirect_to root_url
    else
      flash[:notice] = "Event creation failed."
      redirect_to new_event_path
    end
  end
  
  def show
    @event = Event.find(params[:id])
    @comment = Comment.new
    
    @page = params[:page] || 1
    begin
      @photos = Flickr.new.photos.paginate(:tags => "sex", :page => @page, :per_page => 5)
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
  
  def search
    term = params[:term]
    @events = Event.find(:all, "label like '%#{term}%' or name like '%#{term}%' or description like '%#{term}'%")
    redirect_to event_list_path(@events)
  end
end
