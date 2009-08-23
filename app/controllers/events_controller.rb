class EventsController < ApplicationController
  before_filter :require_login, :except => [:index, :show]
  
  def index
    events
        
    @close_events = Event.find_within(500, :origin => location)
                              
    @user_session = UserSession.new
    
    @map = GMap.new("map_div")
    @map.control_init(:small_zoom => true) #add :large_map => true to get zoom controls
    @map.center_zoom_init([location.lat,location.lng], 6)
    @map.overlay_init(GMarker.new([location.lat,location.lng], :title => "You are here", :info_window => "You are here"))
    
    @close_events.each do |event|
      @map.overlay_init(GMarker.new([event.lat,event.lng],:title => event.name, :info_window => event.name))
    end
    
  end
  
  def new
    @event = Event.new
    
    events
                              
    @close_events = Event.find_within(500, :origin => location)
    
    render
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
      render :new
    end
  end
  
  def show
    
    @event = Event.find(params[:id])
    @comment = Comment.new
    
    @map = GMap.new("map_div")
    @map.control_init(:small_zoom => true) #add :large_map => true to get zoom controls
    @map.center_zoom_init([@event.lat,@event.lng], 15)
    @map.overlay_init(GMarker.new([@event.lat,@event.lng], :title => @event.name, :info_window => @event.name))
    
    
    @pageV = params[:pageV] || 1
    @pageP = params[:pageP] || 1
    @pageT = params[:pageT] || 1
    begin
      @photos = Flickr.new.photos.paginate(:tags => "sex", :page => @page, :per_page => 5)
     rescue
      @photos = []
    end
    
    @twitter = Twitter::Search.new(@event.label).page(@pageT).fetch().results[0..4]

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
    @events = Event.paginate :per_page => 10, 
                   :page => params[:page], 
                   :conditions => "label like '%#{term}%' or name like '%#{term}%' or description like '%#{term}'%"
    # @events = Event.find(:all, "label like '%#{term}%' or name like '%#{term}%' or description like '%#{term}'%")
    # redirect_to event_list_path(@events)
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