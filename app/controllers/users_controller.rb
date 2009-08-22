class UsersController < ApplicationController
  def new
    @user = User.new(params[:openid_identifier])
  end
end
