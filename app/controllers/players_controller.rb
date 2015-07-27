class PlayersController < ApplicationController

  EXCEPTIONS = [URI::InvalidURIError, LinkThumbnailer::Exceptions]

  def show
    @player = Player.find_by("account_id = #{params[:id]}")
    @player_matches = PlayerMatch.where("account_id = :account_id and start_time > :start_time", account_id: @player.account_id, start_time: 1430395200)
    @submissions = @player.submissions.order(:cached_votes_up => :desc)
    @submission = Submission.new
    @videos = []
    @images = []
    @submissions.each do |submission|
      begin
        link_thumbnail = LinkThumbnailer.generate(submission.content)
        unless link_thumbnail.videos[0].nil?
          video = link_thumbnail.videos[0].src
          @videos << video
        else
          image = link_thumbnail.images[0].src
          @images << image
        end
      rescue *EXCEPTIONS
        @videos << nil
        @images << nil
      end
    end
    @player_hero_id = @player.hero_id
    @player_hero = @player.hero
  end
end
