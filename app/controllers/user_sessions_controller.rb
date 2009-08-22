class UserSessionsController < ApplicationController
  def create
    @user_session = UserSession.new(params[:user_session])
    
    @user_session.save do |result|
       if result
         flash[:notice] = "Login successful!"
         redirect_to root_url
       else
         flash[:notice] = "Login failed!"
         redirect_to root_url
       end
     end
  end
end
