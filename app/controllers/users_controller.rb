class UsersController < ApplicationController

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.new(params[:user])
    
    @user.save do |result|
      if result
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
