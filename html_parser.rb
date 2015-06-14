require 'nokogiri'
require 'open-uri'
require 'pry'

file = Nokogiri::HTML(open("http://www.gosugamers.net/dota2/rankings#team"))

team_names = file.css("span[class='main no-game']")

team_names_2 = []

team_names.each do |team|
  team_names_2 << team.children[-1].text
end

puts team_names_2
