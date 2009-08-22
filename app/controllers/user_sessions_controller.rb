class UserSessionsController < ApplicationController
  def create
    @user_session = UserSession.new(params[:user_session])

    @user_session.save do |result|
       if result
         flash[:notice] = "Login successful!"
         redirect_to root_url
       else
         @user = User.new
         @user.openid_identifier = params[:"openid.identity"]
         @user.save
         redirect_to edit_user_path(@user)
       end
     end
  end
end
