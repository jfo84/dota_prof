class TeamsController < ApplicationController
	def index
    @teams = Team.where("top_50 = true")
	end

  def show
  	@team = Team.find(params[:id])
  end
end
