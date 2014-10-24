class UsersController < ApplicationController

  require 'net/http'

  def index

  end

  def create
    @user = User.create(user_params)

    if @user.save
      flash[:alert] = "saved"
      render :index
    else
      flash[:alert] = "not saved"
      render :index
    end

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
    require(:user).permit(:name, :github_username)
  end

end
