class AppMailer < ActionMailer::Base

  default from: 'pmichaeljones@gmail.com'

  def send_secret_token(user_id)
    @user = User.find(user_id)
    mail(to: @user.email, subject: "Your TeaLeaf Leaderboard Secret Token")
  end

  def send_admin_email(user_id)
    @user = User.find(user_id)
    mail(to: "pmichaeljones@gmail.com", reply_to: "#{@user.email}", subject: "New Leaderboard Signup")
  end



end
