require 'nokogiri'
require 'open-uri'
require 'chinese_pinyin'
require 'httparty'

RANKINGS_URL = "http://www.gosugamers.net/dota2/rankings#team"

class WebScraper

  attr_reader :file

  def initialize
    @file ||= Nokogiri::HTML(open(RANKINGS_URL))
  end

  def team_names
    team_names = file.css("span[class='main no-game']")
    team_names.map { |team| team.children[-1].text }
  end

  def team_ids
    team_ids = file.css("tr[class='ranking-link']")
    team_ids.map { |team_data| team_data.attributes["data-id"].text }
  end

  def make_slugs
    team_hash = Hash[team_ids.zip(team_names.map)]
    team_url_slugs = []
    team_hash.each do |team_id, name|
      name.gsub!(" ", "-")
      name.gsub!(".", "-")
      team_url_slugs << "#{team_id}-#{name.downcase}"
    end
    team_url_slugs
  end

  def rosters_array
    rosters_array = []
    make_slugs.each do |team_url_slug|
      @file_2 = Nokogiri::HTML(open("http://www.gosugamers.net/dota2/teams/#{team_url_slug}"))
      roster = @file_2.css("h5")
      roster_array = roster.map { |player| player.text }
      rosters_array << roster_array
    end
    rosters_array
  end

  def database_entry
    counter = 0
    rosters_array.each do |roster|
      curr_team = team_names[counter]
      Team.create!(name: curr_team, roster: roster, top_50: true)
      counter += 1
    end
  end

  def image_urls
    image_urls = []
    make_slugs.each do |team_url_slug|
      @file_2 = Nokogiri::HTML(open("http://www.gosugamers.net/dota2/teams/#{team_url_slug}"))
      image = @file_2.css("div[class='image']")
      image.each do |url|
        if url.attributes["style"].value.include?('players')
          image_urls << "http://www.gosugamers.net#{url.attributes["style"].value[23..-4]}"
        else
          image_urls << "http://www.gosugamers.net#{url.attributes["style"].value[23..-3]}"
        end
      end
    end
    image_urls
  end

  def create_images
    team_urls = []
    player_urls = []
    image_urls.each do |image_url|
      if image_url.include?("teams")
        team_urls.push(image_url)
      else
        player_urls.push(image_url)
      end
    end
    team_urls.each_with_index do |team_url, index|
      File.open("/Users/JRF/my_tools/dota_prof/app/assets/images/teams/team_#{index}.jpg", "wb") do |f|
        f.write HTTParty.get(team_url).parsed_response
      end
    end
    player_urls.each_with_index do |player_url, index|
      File.open("/Users/JRF/my_tools/dota_prof/app/assets/images/players/player_#{index}.jpg", "wb") do |f|
        f.write HTTParty.get(player_url).parsed_response
      end
    end
  end

  # def roster_hash
  #   Hash[team_names.zip(rosters_array.map)]
  # end

  # def player_list
  #   player_list = []
  #   rosters_array.each do |roster|
  #     player_list = roster.map { |player| player }
  #   end
  #   player_list
  # end

  # def print_rosters
  #   roster_hash.each_with_index do |(team_name, roster), index|
  #     puts "#{index + 1}. #{team_name}"
  #     roster.each do |player|
  #       puts "  - #{player}"
  #     end
  #   end
  # end

  # BING STARTED LIMITING. DON'T USE
  #
  # def scrape_account_id
  #   id_array = []
  #   roster_hash.each do |team_name, roster|
  #     roster.each do |player|
  #       @file_3 = Nokogiri::HTML(open("http://www.bing.com/search?q=#{player}+#{team_name}+player+dotabuff"))
  #       id = @file_3.css("cite")
  #       id_array << id[0].text
  #       sleep 10
  #     end
  #   end
  #   id_array
  # end

end
