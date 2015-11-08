require 'nokogiri'
require 'open-uri'
require 'httparty'
require 'json'
require 'pry'

require_relative 'assets/account_id'
require_relative 'assets/team_data'

LEAGUE_ID_URL = "http://dota2.prizetrac.kr/leagues"

def league_ids
  @file = Nokogiri::HTML(open(LEAGUE_ID_URL))
  league_ids = @file.css("tr[id='leagues']")
  league_ids_2 = []
  league_ids.each do |league_id|
    text = league_id.children[-1].children.children.text
    text = text.split(' ')[-1].to_i
    league_ids_2 << text
  end
  league_ids_2.reject! { |league_id| league_id == 0 }
  league_ids_2
end

def league_match_ids
  league_match_ids_2 = []
  league_ids.each do |league_id|
    counter = 0
    @url = "http://api.steampowered.com/IDOTA2Match_570/GetMatchHistory/v001/?key=2821A34B97E539012E2EA60D19D0A917&league_id=#{league_id}"
    steam_data = HTTParty.get(@url, timeout: 60)
    match_id_array = []
    until counter == 2 || steam_data["result"]["matches"].count <= 1
      steam_data["result"]["matches"].each do |match_data|
        match_id_array << match_data["match_id"] unless match_id_array.include?(match_data["match_id"])
      end
      last_id = steam_data["result"]["matches"][-2]["match_id"]
      @url = "http://api.steampowered.com/IDOTA2Match_570/GetMatchHistory/v001/?key=2821A34B97E539012E2EA60D19D0A917&league_id=#{league_id}&start_at_match_id=#{last_id}"
      steam_data = HTTParty.get(@url, timeout: 60)
      sleep 1
      counter += 1 if steam_data["result"]["results_remaining"] == 0
    end
    league_match_ids_2 << match_id_array
  end
  league_match_ids_2
end

def database_entry
  league_match_ids.each do |match_id_array|
    unless match_id_array.empty?
      match_id_array.each do |match_id|
        @url = "http://api.steampowered.com/IDOTA2Match_570/GetMatchDetails/v001/?key=2821A34B97E539012E2EA60D19D0A917&match_id=#{match_id}"
        steam_data = HTTParty.get(@url, timeout: 60)
        start_time = match.payload["result"]["start_time"]
        match_id = match.payload["result"]["match_id"]
        game_mode = steam_data["result"]["game_mode"]
        if game_mode == 1 || game_mode == 2
          Match.create!(payload: steam_data, start_time: start_time, match_id: match_id)
        end
        sleep 1
      end
    end
  end
end

