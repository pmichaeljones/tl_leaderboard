class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def create
    @user = User.new(user_params)
    @users = User.all

    if @user.github_user?
      if @user.save
        @user.update_user_info
        AppMailer.send_secret_token(@user.id).deliver
        flash[:success] = "Success! Your secret token is: #{@user.secret}"
        redirect_to root_path
      else
        flash[:error] = "Must include name, GitHub username and email address."
        render :index
      end
    else
      flash[:error] = "That GitHub user doesn't exist"
      render :index
    end
  end

  def update_users
    User.update_github_info_for_all
    @users = User.all
    flash[:info] = "Leaderboard Updated!"
    render :index
  end

  def delete_user
    @user = User.find(params[:user_id])
  end


  def destroy_user
    @user = User.find(params[:user_id])

    if @user.secret == params[:secret_token]
      @user.delete
      flash[:success] = "#{@user.github_username} deleted from leaderboard"
      redirect_to root_path
    else
      flash[:error] = "That is not the correct secret code for #{@user.github_username}"
      render :delete_user
    end

  end

  #actions to resend the user secret token

  def new_token
  end

  def send_token
    @user = User.find_by(github_username: params[:github_name])
    if @user
      AppMailer.send_secret_token(@user.id).deliver
      flash[:success] = "We just sent an email to #{@user.email}."
    else
      flash[:error] = "Unable to find #{params[:github_name]} in our database."
    end
    render :new_token
  end

  #end secret token methods

  private

  def user_params
    params.require(:user).permit(:name, :github_username, :email)
  end

end
