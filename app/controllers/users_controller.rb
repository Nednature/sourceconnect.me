class UsersController < ApplicationController
  def index
    @users = User.all
    respond_to do |f|
      f.html
      f.json
    end
  end
  def show
    @user = User.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end
end