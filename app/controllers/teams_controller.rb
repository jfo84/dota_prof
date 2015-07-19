class TeamsController < ApplicationController
	def index
    @teams = Team.where("rank <= 25").order(rank: :asc)
		team_ids = []
		@teams.each do |team|
			team_ids << team.team_id
		end
		@eight_four_matches = team_ids.map { |team_id| TeamMatch.where(team_id: team_id) }
		@captain_list = []
		@win_list = []
		@pick_list = []
		@ban_list = []
    @eight_four_matches.each do |team_matches|
			captain_counts = Hash.new(0)
			win_counts = Hash.new(0)
			pick_counts = Hash.new(0)
			ban_counts = Hash.new(0)
			team_matches.each do |team_match|
				captain_counts[team_match.captain_id] += 1
				if team_match.radiant == true && team_match.radiant_win == true
					win_counts[team_match.captain_id] += 1
				elsif team_match.radiant == false && team_match.radiant_win == false
					win_counts[team_match.captain_id] += 1
				end
				unless team_match.picks.nil? && team_match.bans.nil?
					team_match.picks.each do |hero_id|
						pick_counts[hero_id] += 1
					end
					team_match.bans.each do |hero_id|
						ban_counts[hero_id] += 1
					end
				end
			end
			captain_counts.delete_if{|k, v| k.nil? }
			win_counts.delete_if{|k, v| k.nil? }
			@captain_list << captain_counts.sort_by{|k, v| -v}
			@win_list << win_counts.sort_by{|k, v| -v}
			@pick_list << pick_counts.sort_by{|k, v| -v}
			@ban_list << ban_counts.sort_by{|k, v| -v}
		end
		@players = Player.all
	end

  def show
  	@team = Team.find(params[:id])
	end
end
