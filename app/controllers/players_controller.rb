class PlayersController < ApplicationController
  def show
    @player = Player.find_by("account_id = #{params[:id]}")
    @submissions = @player.submissions.order(:cached_votes_up => :desc)
    @submission = Submission.new

    @eight_four_matches = PlayerMatch.where("account_id = :account_id and start_time > :start_time", account_id: params[:id], start_time: 1430395200)
    counts = Hash.new(0)
    @eight_four_matches.each { |player_match| counts[player_match.hero_id] += 1 }
    @eight_four_hero_id = counts.sort_by{|x,y| y}.last[0]
    HeroID::HERO_HASH[:result][:heroes].each do |hero|
      if @eight_four_hero_id == hero[:id]
        @eight_four_hero = hero[:name]
      end
    end
  end
end

=begin

6.84 began @ 1430395200
6.83 @ 1418817600
6.82 @ 1411560000

=end
