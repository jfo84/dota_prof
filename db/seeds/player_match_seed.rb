class PlayerMatchSeed
  attr_accessor :matches

  def initialize
    matches = Match.all
  end

  def player_match_seed
    matches.each do |match|
      match.payload["result"]["players"].each_with_index do |player, index|
        player_match = PlayerMatch.new
        account_id = player["account_id"]
        hero_id = player["hero_id"]
        kills = player["kills"]
        deaths = player["deaths"]
        assists = player["assists"]
        gpm = player["gold_per_min"]
        xpm = player["xp_per_min"]
        hero_damage = player["hero_damage"]
        tower_damage = player["tower_damage"]
        last_hits = player["last_hits"]
        denies = player["denies"]
        inventory = []
        0.upto(5) do |i|
          inventory << player["item_#{i}"]
        end
        radiant_win = match.payload["result"]["radiant_win"],
        start_time = match.payload["result"]["start_time"],
        match_id = match.payload["result"]["match_id"]
        player_match.assign_attributes(account_id: account_id,
                                     hero_id: hero_id,
                                     kills: kills,
                                     deaths: deaths,
                                     assists: assists,
                                     gpm: gpm,
                                     xpm: xpm,
                                     hero_damage: hero_damage,
                                     tower_damage: tower_damage,
                                     last_hits: last_hits,
                                     denies: denies,
                                     inventory: inventory,
                                     radiant_win: radiant_win,
                                     start_time: start_time,
                                     match_id: match_id
        )
        if index < 5
          player_match.assign_attributes(radiant: true)
        end
        player_match.save!
      end
    end
  end
end
