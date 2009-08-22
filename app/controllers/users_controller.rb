class UsersController < ApplicationController
  def new
    @user = User.new
    @user.openid_identifier = params[:identity]
  end
  
  def create
    @user = User.new(params[:user])
    
    @user.save do |result|
      if result
        UserSession.create(@user)
        flash[:notice] = "Success"
        redirect_to root_url
      else
        flash[:notice] = "Fail"
        render :new
      end
    end
  end
end
