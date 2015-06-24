class PlayersController < ApplicationController
	def index
    # @players = Player.where("team_id.top_50 = true") or something
	end

  def show
    # @player = Player.where("payload -> 'result' -> 'players' ->> 'account_id' = params[:id]")
  end
end
