require 'nokogiri'
require 'open-uri'

@file = Nokogiri::HTML(open("http://www.gosugamers.net/dota2/rankings#team"))

team_names = @file.css("span[class='main no-game']")
team_names_2 = []
team_names.each do |team|
  team_names_2 << team.children[-1].text
end

team_ids = @file.css("tr[class='ranking-link']")
team_ids_2 = []
team_ids.each do |team_data|
  team_ids_2 << team_data.attributes["data-id"].text
end

team_hash = Hash[team_ids_2.zip(team_names_2.map {|values| values})]
team_urls = []
team_hash.each do |team_id, name|
  name.gsub!(" ", "-")
  name.gsub!(".", "-")
  team_urls << "#{team_id}-#{name.downcase}"
end

rosters_array = []

team_urls.each do |team_url|
  @file_2 = Nokogiri::HTML(open("http://www.gosugamers.net/dota2/teams/#{team_url}"))
  roster = @file_2.css("h5")
  roster_array = []
  roster.each do |player|
    roster_array << player.text
  end
  rosters_array << roster_array
end

@roster_hash = Hash[team_names_2.zip(rosters_array.map {|values| values})]
