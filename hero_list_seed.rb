def hero_list_seed
  matches = Match.all
  matches.each do |match|
    account_id_list = []
    hero_id_list = []
    match.payload["result"]["players"].each do |player|
      account_id_list << player["account_id"]
      hero_id_list << player["hero_id"]
    end
    counter = 0
    start_time = match.payload["result"]["start_time"]
    if account_id_list.length == 10
      account_id_list.length.times do
        hero_list = HeroList.new
        hero_list.assign_attributes(account_id: account_id_list[counter], hero_id: hero_id_list[counter], start_time: start_time)
        hero_list.save! unless hero_list.account_id.nil? || hero_list.hero_id.nil?
        counter += 1
      end
    end
  end
end


# game_mode's 1 and 2 are all we want. Fixed on SQL insert side

# def bad_games
#   counter = 3
#   19.times do
#     Match.where("payload -> 'result' ->> 'game_mode' = '#{counter}'").destroy_all
#     counter += 1
#   end
#   Match.where("(payload -> 'result' ->> 'radiant_team_id') is null").destroy_all
#   Match.where("(payload -> 'result' ->> 'dire_team_id') is null").destroy_all
# end

# hero_played_hash = Hash.new[account_id_list.zip(hero_list.map)]

# Calculating values from matches db for team db

# win_count = 0; lose_count = 0; win_count_2 = 0; lose_count_2 = 0
#
# @matches_rad.each do |match|
#   if match.payload["result"]["radiant_win"] == true
#     win_count += 1
#   else
#     lose_count += 1
#   end
# end
#
# @matches_dire.each do |match|
#   if match.payload["result"]["radiant_win"] == false
#     win_count_2 += 1
#   else
#     lose_count_2 += 1
#   end
# end
