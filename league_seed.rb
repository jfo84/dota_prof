def league_seed
  matches = Match.all
  matches.each do |match|
    league_id = match.payload["result"]["leagueid"]
    League.find_or_create_by(league_id: league_id)
  end
end
