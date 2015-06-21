require 'pry'
require 'redis'
require 'httparty'
require 'json'

require_relative 'dota_scraper'
require_relative 'assets/account_id'
require_relative 'assets/team_data'

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

def get_match_ids
  TEAM_NAMES_AND_IDS[0].each do |team_name, team_id|
    @url = "http://api.steampowered.com/IDOTA2Match_570/GetMatchHistory/v001/?key=2821A34B97E539012E2EA60D19D0A917&team_id=#{team_id}"
    steam_data = HTTParty.get(@url)
    matches = steam_data["result"]["matches"]
    match_id_array = []
    until matches.length < 100
      matches = steam_data["result"]["matches"]
      matches.each do |match_data|
        match_id_array << match_data["match_id"] unless match_id_array.include?(match_data["match_id"])
      end
      last_id = steam_data["result"]["matches"].last["match_id"]
      @url = "http://api.steampowered.com/IDOTA2Match_570/GetMatchHistory/v001/?key=2821A34B97E539012E2EA60D19D0A917&team_id=#{team_id}&start_at_match_id=#{last_id}"
      steam_data = HTTParty.get(@url)
      sleep 2
    end
    top_fifty_match_ids = []
    top_fifty_match_ids << match_id_array
  end
  top_fifty_match_ids
end

get_match_ids

# max_date=#{steam_data["result"]["matches"][99]["match_seq_num"]}
# redis.set team_id, steam_data
