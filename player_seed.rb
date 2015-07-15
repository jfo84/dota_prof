def player_seed
  matches = Match.all
  matches.each do |match|
    match.payload["result"]["players"].each do |player|
      account_id = player["account_id"]
      Player.find_or_create_by(account_id: account_id)
    end
  end
  nil
end
