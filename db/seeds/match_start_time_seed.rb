matches = Match.all
matches.each do |match|
  start_time = match.payload["result"]["start_time"]
  match_id = match.payload["result"]["match_id"]
  match.assign_attributes(start_time: start_time, match_id: match_id)
  match.save!
end
