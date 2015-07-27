class TeamsController < ApplicationController
	def index
    @teams = Team.where("rank <= 25").order(rank: :asc)
		@team_matches = Team.team_matches
		@captain_list = Team.captain_list
		@win_list = Team.win_list
		@pick_list = Team.pick_list
		@ban_list = Team.ban_list
		@players = Player.all
	end

  def show
  	@team = Team.find(params[:id])
	end
end
