class PlayersController < ApplicationController
  def show
    # @player = Player.where("payload -> 'result' -> 'players' ->> 'account_id' = params[:id]")
  end
end
