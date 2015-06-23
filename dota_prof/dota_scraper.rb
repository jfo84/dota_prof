require 'nokogiri'
require 'open-uri'
require 'chinese_pinyin'

require_relative 'assets/account_id'

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

  def scrape_rosters
    rosters_array = []
    make_slugs.each do |team_url_slug|
      @file_2 = Nokogiri::HTML(open("http://www.gosugamers.net/dota2/teams/#{team_url_slug}"))
      roster = @file_2.css("h5")
      roster_array = roster.map { |player| player.text }
      rosters_array << roster_array
    end
    rosters_array
  end

  def roster_hash
    Hash[team_names.zip(scrape_rosters.map)]
  end

  def player_list
    player_list = []
    scrape_rosters.each do |roster|
      player_list = roster.map { |player| player }
    end
    player_list
  end

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
