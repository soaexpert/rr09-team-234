class UserSessionsController < ApplicationController
  def create
    @user_session = UserSession.new(params[:user_session])
    
    @user_session.save do |result|
       if result
         flash[:notice] = "Login successful!"
         redirect_to root_url
       else
         puts @user_session.openid_identifier
         redirect_to new_user_path, :openid_identifier => @user_session.openid_identifier
       end
     end
  end
end
