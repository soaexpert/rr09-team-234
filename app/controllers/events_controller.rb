class EventsController < ApplicationController
  before_filter :require_login, :except => [:index, :show]
  
  def index
    events
    
    @location = session[:geo_location]
                             
    @close_events = Event.find_within(500, :origin => location)
                              
    @user_session = UserSession.new
    
    @map = GMap.new("map_div")
    @map.control_init(:large_map => true) #add :large_map => true to get zoom controls
    @map.center_zoom_init([location.lat,location.lng], 6)
    @map.overlay_init(GMarker.new([location.lat,location.lng], :title => "You are here", :info_window => "You are here"))
    
    @close_events.each do |event|
      @map.overlay_init(GMarker.new([event.lat,event.lng],:title => event.name, :info_window => event.name))
    end
    
    render :layout => 'home'
  end
  
  def new
    @event = Event.new
    
    events
                              
    @close_events = Event.find_within(500, :origin => location)
    
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
      events
      render :new, :layout => 'home'
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

    render
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

private

def events
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