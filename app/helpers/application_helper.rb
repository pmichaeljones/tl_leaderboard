module ApplicationHelper

  require 'net/http'
  require 'JSON'
  require 'open-uri'

  def scrape_for_contrib_number(username)
    doc = Nokogiri::HTML(open("https://github.com/#{username}"))
    contributions = doc.css("span.contrib-number")[0].text
    return contributions
  end

  def update_list(user_list)

    user_list.each do |user|
      doc = Nokogiri::HTML(open("https://github.com/#{user.github_username}"))
      contributions = doc.css("span.contrib-number")[0].text
      user.update_column(:contributions, contributions)
    end

  end

end