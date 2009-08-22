class UserSessionsController < ApplicationController
  def create
    @user_session = UserSession.new(params[:user_session])

    @user_session.save do |result|
       if result
         flash[:notice] = "Login successful!"
         redirect_to root_url
       else
         redirect_to new_user_path :identity => params[:"openid.identity"]
       end
     end
  end
end
