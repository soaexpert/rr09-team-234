class UsersController < ApplicationController
  def new
    events
    
    @user = User.new
    @user.openid_identifier = params[:identity]

  end
  
  def create
    events
    
    @user = User.new(params[:user])
    
    @user.save do |result|
      if result
        UserSession.create(@user)
        flash[:notice] = "Success"
        redirect_to root_url, :layout => "home"
      else
        flash[:notice] = "Fail"
        render :new
      end
    end
  end
  
  def edit
    events
    
    @user = current_user
  end
  
  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      flash[:notice] = "User updated successfuly!"
      redirect_to root_url, :layout => "home"
    else
      events
      flash[:notice] = "User update failed."
      render :edit
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
                            
    @close_events = Event.find_within(200, :origin => location)
  end
  

end
