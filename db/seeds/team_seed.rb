require 'open-uri'

class TeamSeed

  def team_seed
    matches = Match.all.order(:start_time)
    matches.each do |match|
      rad_team_id = match.payload["result"]["radiant_team_id"]
      rad_name = match.payload["result"]["radiant_name"]
      rad_id_roster = []
      dire_team_id = match.payload["result"]["dire_team_id"]
      dire_name = match.payload["result"]["dire_name"]
      dire_id_roster = []
      rad_team = Team.find_or_create_by(team_id: rad_team_id, name: rad_name)
      dire_team = Team.find_or_create_by(team_id: dire_team_id, name: dire_name)
      match.payload["result"]["players"].each_with_index do |player, index|
        if index < 5
          rad_id_roster << player["account_id"].to_s
        else
          dire_id_roster << player["account_id"].to_s
        end
      end
      rad_team.update(id_roster: rad_id_roster)
      dire_team.update(id_roster: dire_id_roster)
    end
    nil
  end

  def roster_seed
    teams = Team.where("top_50 = true")
    teams.each do |team|
      roster = []
      team.id_roster.each do |account_id|
        player = Player.find_by account_id: account_id
        unless player.name.nil? || player.nil?
          roster << player.name
        else
          roster << "Blank"
        end
      end
      team.update!(roster: roster)
    end
  end

end
