# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  helper_method :current_user_session, :current_user
  
  geocode_ip_address

  private
    def current_user_session
      return @current_user_session if defined?(@current_user_session)
      @current_user_session = UserSession.find
    end

    def current_user
      return @current_user if defined?(@current_user)
      @current_user = current_user_session && current_user_session.user
    end
    
    def require_login
      unless current_user
        flash[:notice] = "Must be logged in"
        session[:restricted_url_to_access] = request.url
        redirect_to root_url
      end
    end
    
    def location
      session[:geo_location]
    end
  
  protected
  
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
      
      video_list.reverse[0..1]

    end

end
