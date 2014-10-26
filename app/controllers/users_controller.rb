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
    #binding.pry
    @user = User.new(user_params)
    if @user.save
      if check_user_name(@user.github_username) == false
        @user.delete
        flash[:alert] = "That GitHub user doesn't exist!"
        redirect_to root_path
      else
        flash[:info] = "You're On the Leaderboard!"
        User.update
        sort_users
        render :index
      end
    else
      flash[:alert] = "Username's must match!"
      redirect_to root_path
    end

  end


  private

  def sort_users
    @users = User.order(contributions: :desc)
  end

  def user_params
    params.require(:user).permit(:name, :github_username, :email)
  end

end
