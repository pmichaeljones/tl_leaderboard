class UsersController < ApplicationController

  require 'net/http'

  def index
    sort_users
  end

  def update_users
    User.update
    sort_users
    flash[:info] = "Leaderboard Updated!"
    render :index
  end


  def create
    @user = User.new(user_params)
    @user.save
    render :index
    flash[:error] = "Must include name, GitHub username and email address."
  end


  private



  def sort_users
    @users = User.order(contributions: :desc)
  end

  def user_params
    params.require(:user).permit(:name, :github_username, :email)
  end

end
