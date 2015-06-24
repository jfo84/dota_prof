class TeamsController < ApplicationController
	def index
		@teams = Team.all #placeholder
    # @teams = Team.where("top_50 = true")
	end

  def show
    # @team = Team.where("payload -> 'result' ->> 'radiant_team_id' = params[:id]")
    # need to use collection_select in the erb instead
  end
end
