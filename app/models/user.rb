class User < ActiveRecord::Base

  validates_presence_of :name
  validates_uniqueness_of :github_username
  validates :github_username, confirmation: true
  validates :github_username_confirmation, presence: true

  require 'net/http'
  require 'JSON'
  require 'open-uri'

  def get_contributions
    doc = Nokogiri::HTML(open("https://github.com/#{self.github_username}"))
    contributions = doc.css("span.contrib-number")[0].text.remove!(" total")
    update_column(:contributions, contributions.to_i)
    return contributions
  end

  def get_streak
    doc = Nokogiri::HTML(open("https://github.com/#{self.github_username}"))
    streak = doc.css("span.contrib-number")[2].text.remove!(" days")
    update_column(:streak, streak.to_i)
    return streak
  end

  # def update_list(user_list)

  #   user_list.each do |user|
  #     doc = Nokogiri::HTML(open("https://github.com/#{user.github_username}"))
  #     contributions = doc.css("span.contrib-number")[0].text
  #     user.update_column(:contributions, contributions)
  #   end

  # end

end
