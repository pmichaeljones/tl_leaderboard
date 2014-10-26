class User < ActiveRecord::Base

  validates_presence_of :name, :email, :github_username
  validates_uniqueness_of :github_username

  require 'net/http'
  require 'open-uri'

  def github_contributions
    doc = Nokogiri::HTML(open("https://github.com/#{self.github_username}"))
    contributions = doc.css("span.contrib-number")[0].text.remove!(" total")
    contributions.remove!(",")
    contributions.to_i
  end

  def github_streak
    doc = Nokogiri::HTML(open("https://github.com/#{self.github_username}"))
    streak = doc.css("span.contrib-number")[2].text.remove!(" days")
    streak.to_i
  end

  def github_user?
    uri = URI("https://github.com/#{self.github_username}/")
    response = Net::HTTP.get_response(uri)
    if response.code == '404'
      return false
    else
      return true
    end
  end

  def update_user_info
    self.contributions = github_contributions
    self.streak = github_streak
  end


  # def self.update
  #   users = User.all
  #   users.each do |user|
  #     user.get_contributions
  #     user.get_streak
  #   end
  # end

end
