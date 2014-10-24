class UsersController < ApplicationController

  require 'net/http'

  def index
    @users = User.all
  end

  def create
    username = params[:user][:github_username]

    if github_user_exists?(username) == false
      flash[:error] = "Username doesn't exist"
      redirect_to :index
    else
      @user = User.create(user_params)
      if @user.save
        flash[:alert] = "You're On the Leaderboard!"
      else
        flash[:alert] = "Try Again!"
      end
    end
    #update the data of all current users
    User.update
    @users = User.all
    render :index
  end


  private

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
