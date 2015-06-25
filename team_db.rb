win_count = 0; lose_count = 0; win_count_2 = 0; lose_count_2 = 0

@matches_rad.each do |match|
  if match.payload["result"]["radiant_win"] == true
    win_count += 1
  else
    lose_count += 1
  end
end

@matches_dire.each do |match|
  if match.payload["result"]["radiant_win"] == false
    win_count_2 += 1
  else
    lose_count_2 += 1
  end
end
