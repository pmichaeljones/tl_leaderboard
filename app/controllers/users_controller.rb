class UsersController < ApplicationController

  require 'net/http'

  def index
    sort_users
  end

  def update_users
    User.update
    sort_users
    render :index
  end


  def create
    @user = User.create(user_params)
    if @user.save
      check_user_name(@user.github_username)
      flash[:info] = "You're On the Leaderboard!"
      User.update
      sort_users
      render :index
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
      flash[:error] = "That GitHub user doesn't exist."
      bad_user = User.find_by(username: username)
      bad_user.delete
      redirect_to index_path
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
