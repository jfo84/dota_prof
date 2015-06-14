require 'nokogiri'
require 'mechanize'
require 'open-uri'
require 'pry'

@file = Nokogiri::HTML(open("http://www.gosugamers.net/dota2/rankings#team"))

def scrape_team_names
  team_names = @file.css("span[class='main no-game']")
  @team_names_2 = []
  team_names.each do |team|
    @team_names_2 << team.children[-1].text
  end
  puts @team_names_2
end

def scrape_player_names

  agent = Mechanize.new

  agent.get('http://www.gosugamers.net/dota2/rankings#team') do |team_page|

    @team_names_2.each do |team|
      agent.click(team_page.link_with(:text => /#{team}/))
      roster_info = @file.css("div[id='roster']")
      @roster_info_2 = []
      roster_info.each do |roster|
        roster.children.each do |player|
          @roster_info_2 << player.text
        end
      end
    end
  end
  puts @roster_info_2
end

scrape_team_names
scrape_player_names
