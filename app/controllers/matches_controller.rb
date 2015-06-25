class MatchesController < ApplicationController
	def index
		@matches_rad = Match.where("payload -> 'result' ->> 'radiant_team_id' = '1838315'")
		@matches_dire = Match.where("payload -> 'result' ->> 'dire_team_id' = '1838315'")
	end

  def show

  end
end
