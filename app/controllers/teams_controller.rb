class TeamsController < ApplicationController
	def index
    @teams = Team.where("top_50 = true")
		@players = Player.all
	end

  def show
  	# @team = Team.find(params[:id])
		# Secret example
		@team_matches = Match.where("payload -> 'result' ->> 'radiant_team_id' = '1838315' OR payload -> 'result' ->> 'dire_team_id' = '1838315'")
  end
end
