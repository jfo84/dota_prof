class TeamsController < ApplicationController
	def index
    @teams = Team.where("rank <= 25").order(rank: :asc)
		@players = Player.all
	end

  def show
  	@team = Team.find(params[:id])
	end
end
