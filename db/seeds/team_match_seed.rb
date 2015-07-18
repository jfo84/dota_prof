class TeamMatchSeed
  attr_accessor :matches

  def initialize
    @matches ||= Match.all
  end

  def team_match_seed
    matches.each do |match|
      rad_name = match.payload["result"]["radiant_name"]
      rad_team_id = match.payload["result"]["radiant_team_id"]
      rad_captain_id = match.payload["result"]["radiant_captain"]
      rad_picks = []
      rad_bans = []
      dire_name = match.payload["result"]["dire_name"]
      dire_team_id = match.payload["result"]["dire_team_id"]
      dire_captain_id = match.payload["result"]["dire_captain"]
      dire_picks = []
      dire_bans = []
      league_id = match.payload["result"]["leagueid"]
      match_id = match.payload["result"]["match_id"]
      start_time = match.payload["result"]["start_time"]
      duration = match.payload["result"]["duration"]
      first_blood = match.payload["result"]["first_blood_time"]
      radiant_win = match.payload["result"]["radiant_win"]
      unless match.payload["result"]["picks_bans"].nil?
        match.payload["result"]["picks_bans"].each_with_index do |pick_ban|
          if pick_ban["team"] == 0 && pick_ban["is_pick"] == false
            rad_bans << pick_ban["hero_id"]
          elsif pick_ban["team"] == 0 && pick_ban["is_pick"] == true
            rad_picks << pick_ban["hero_id"]
          elsif pick_ban["team"] == 1 && pick_ban["is_pick"] == false
            dire_bans << pick_ban["hero_id"]
          elsif pick_ban["team"] == 1 && pick_ban["is_pick"] == true
            dire_picks << pick_ban["hero_id"]
          end
        end
      end
      rad_team_match = TeamMatch.new
      rad_team_match.assign_attributes(team_name: rad_name,
                                   team_id: rad_team_id,
                                   captain_id: rad_captain_id,
                                   picks: rad_picks,
                                   bans: rad_bans,
                                   league_id: league_id,
                                   match_id: match_id,
                                   start_time: start_time,
                                   duration: duration,
                                   first_blood: first_blood,
                                   radiant: true,
                                   radiant_win: radiant_win
      )
      rad_team_match.save!
      dire_team_match = TeamMatch.new
      dire_team_match.assign_attributes(team_name: dire_name,
                                   team_id: dire_team_id,
                                   captain_id: dire_captain_id,
                                   picks: dire_picks,
                                   bans: dire_bans,
                                   league_id: league_id,
                                   match_id: match_id,
                                   start_time: start_time,
                                   duration: duration,
                                   first_blood: first_blood,
                                   radiant: false,
                                   radiant_win: radiant_win
      )
      dire_team_match.save!
    end
    nil
  end
end
