require 'nokogiri'
require 'open-uri'

def scrape_html
  @file ||= Nokogiri::HTML(open("http://www.gosugamers.net/dota2/rankings#team"))
end

def team_names
  team_names = @file.css("span[class='main no-game']")
  team_names_2 = []
  team_names.each do |team|
    team_names_2 << team.children[-1].text
  end
  team_names_2
end

def team_ids
  team_ids = @file.css("tr[class='ranking-link']")
  team_ids_2 = []
  team_ids.each do |team_data|
    team_ids_2 << team_data.attributes["data-id"].text
  end
  team_ids_2
end

def make_slugs
  team_hash = Hash[team_ids.zip(team_names.map {|values| values})]
  team_url_slugs = []
  team_hash.each do |team_id, name|
    name.gsub!(" ", "-")
    name.gsub!(".", "-")
    team_url_slugs << "#{team_id}-#{name.downcase}"
  end
  team_url_slugs
end

def scrape_rosters
  rosters_array = []
  make_slugs.each do |team_url_slug|
    @file_2 = Nokogiri::HTML(open("http://www.gosugamers.net/dota2/teams/#{team_url_slug}"))
    roster = @file_2.css("h5")
    roster_array = []
    roster.each do |player|
      roster_array << player.text
    end
    rosters_array << roster_array
  end
  rosters_array
end

def roster_hash
  Hash[team_names.zip(scrape_rosters.map {|values| values})]
end

def print_rosters
  roster_hash.each_with_index do |(team_name, roster), index|
    puts "#{index + 1}. #{team_name}"
    roster.each do |player|
      puts "- #{player}"
    end
  end
end

scrape_html
scrape_rosters
print_rosters
