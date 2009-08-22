class UsersController < ApplicationController
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    
    @user.update_attributes(params[:user]) do |response|
      if response
        UserSession.create(@user)
        flash[:notice] = "Success"
        redirect_to root_url
      else
        flash[:notice] = "Fail"
        render :edit
      end
    end
  end
end
