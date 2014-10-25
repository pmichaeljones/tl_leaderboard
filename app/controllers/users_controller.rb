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

  def check_user_name(username)
    if github_user_exists?(username) == false
      return false
    else
      return true
    end
  end


  def github_user_exists?(username)
    uri = URI("https://github.com/#{username}/")
    response = Net::HTTP.get_response(uri)
    if response.code == '404'
      return false
    else
      return true
    end
  end

  def user_params
    params.require(:user).permit(:name, :github_username, :github_username_confirmation)
  end

end
