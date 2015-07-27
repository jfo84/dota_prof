class Player < ActiveRecord::Base
  belongs_to :team
  has_many :submissions
  has_many :player_matches

  validates :account_id, presence: true

  def hero_id
    player_matches = PlayerMatch.where("account_id = :account_id and start_time > :start_time", account_id: self.account_id, start_time: 1430395200)
    counts = Hash.new(0)
    player_matches.each { |player_match| counts[player_match.hero_id] += 1 }
    counts.sort_by{|x,y| y}.last[0]
  end

  def hero
    HeroID::HERO_HASH[:result][:heroes].each do |hero|
      if hero_id == hero[:id]
        @player_hero = hero[:name]
      end
    end
    @player_hero
  end
end
