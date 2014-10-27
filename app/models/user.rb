class User < ActiveRecord::Base

  validates_presence_of :name, :email, :github_username
  validates_uniqueness_of :github_username

  require 'net/http'

  def github_contributions
    doc = Nokogiri::HTML(open("https://github.com/#{self.github_username}"))
    contributions = doc.css("span.contrib-number")[0].text.remove!(" total")
    contributions.remove!(",")
    contributions.to_i
  end

  def github_streak
    doc = Nokogiri::HTML(open("https://github.com/#{self.github_username}"))
    streak = doc.css("span.contrib-number")[1].text.remove!(" days")
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
    self.secret = generate_delete_secret
    self.save
  end

  def self.update
    users = User.all
    users.each do |user|
      user.update_user_info
    end
  end

  def generate_delete_secret
    self.secret = Faker::Internet.password
  end


end
