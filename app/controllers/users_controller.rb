class UsersController < ApplicationController

  def index
    @users = User.all
    respond_to do |format|
      format.html
    end
  end
  
  def show
    @collection = User.find(params[:id])
  end
end
