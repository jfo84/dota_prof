require 'factory_girl'

FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    password 'password'
    password_confirmation 'password'
  end

  factory :player do
    name "Best Player"
    account_id 1
  end

  factory :player_match do
    account_id 1
    hero_id 5
    kills 3
    deaths 2
    assists 2
    gpm 500
    xpm 600
    hero_damage 100
    tower_damage 100
    last_hits 100
    denies 100
    radiant true
    radiant_win true
    start_time 1437764282
    match_id 1
  end

  factory :submission do
    content "hella awesome"
    player
    user
  end

  factory :vote do
    submission
    user
  end
end
