require 'hpricot'

class MediasController < ApplicationController
  
  protect_from_forgery :only => [:create, :update, :destroy] 
  
  def videos
    
    @page = params[:pageV]
    @label = params[:label] 
    
    begin 
      start_index = ((@page.to_i - 1) * 2) + 1
      end_index = start_index + 1
 
      @videos = parse_videos(@label, start_index, end_index )
    
    rescue
      puts $!
      @videos = []
    end
    
    render :layout => false
    
  end
  
  def photos
    
    @page = params[:pageP]
    @label = params[:label]
    
    begin 
      @photos = Flickr.new.photos.paginate(:tags => @label, :page => @page, :per_page => 2)
    rescue
      puts $!
      @photos = []
    end
    
    render :layout => false
    
  end  
   
end
