require 'hpricot'

class MediasController < ApplicationController
  
  def videos
    
    @page = params[:page] || 1
    
    begin 
      @videos = parse_videos('yoshima', ((@page - 1) * 5) + 1, 5)
    rescue
      puts $!
      @videos = []
      flash[:notice] = "Videos unavailable..."
    end
    
  end
  
  private
  
  def parse_videos(label, start_index, max_results)
    video_list = []
    feed_contents = "http://gdata.youtube.com/feeds/api/videos/-/#{label}?start_index=#{start_index}&max-results=#{max_results}"
    doc = Hpricot(open(feed_contents))
    
    doc.search("feed//entry").each do |raw_item|
      url = raw_item.at('media:player')['url']
      thumbnail = raw_item.at('media:thumbnail')['url']
      video = {:url => url, :thumbnail => thumbnail}
      video_list << video
    end
    
    video_list
  end
  
end
