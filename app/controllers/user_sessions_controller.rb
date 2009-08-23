class UserSessionsController < ApplicationController
  before_filter :require_login, :only => [:destroy]
  
  def create
    @user_session = UserSession.new(params[:user_session])

    @user_session.save do |result|
       if result
         flash[:notice] = "Login successful!"
         redirect_to(root_url, :layout => "home")
       else
         redirect_to new_user_path(:identity => params[:"openid.identity"]), :layout => "home"
       end
   end
  end
  
  def destroy
    UserSession.find.destroy
    redirect_to root_url
    flash[:notice] = "Logout successfully"
  end
end
