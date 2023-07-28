class UsersController < ApplicationController
  def index
    @users = User.all
    @user = User.find_by(params[:id])
  end

  def show
    @user = User.find(params[:id])
  end
end
