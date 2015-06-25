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
        Match.create!(payload: steam_data)
        sleep 1
      end
    end
  end
end

# def pro_ids
#   Hash[league_ids.zip(league_match_ids.map)]
# end

# For non-league games
#
# def player_id_hash
#   top_fifty_players = player_list[0..49]
#   player_id_hash = Hash[top_fifty_players.zip(ACCOUNT_ID.map)]
# end
#
# player_id_hash.each do |player_name, account_id|
#
# end

# redis = Redis.new

# max_date=#{steam_data["result"]["matches"].last["match_seq_num"]}
# redis.set team_id, steam_data
