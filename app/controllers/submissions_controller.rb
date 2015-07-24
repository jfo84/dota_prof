class SubmissionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_current_models, only: [:edit, :update, :destroy]

  EXCEPTIONS = [URI::InvalidURIError, LinkThumbnailer::Exceptions]

  def new
    @submission = Submission.new
  end

  def create
    @player = Player.find(params[:player_id])
    @submission = Submission.new(submission_params)
    @submission.user = current_user
    @submission.player = @player
    if @submission.save
      flash[:notice] = "Thanks for your submission!"
      redirect_to player_path(@player.account_id)
    else
      flash[:notice] = @submission.errors.full_messages.join(". ")

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

      @eight_four_matches = PlayerMatch.where("account_id = :account_id and start_time > :start_time", account_id: @player.account_id, start_time: 1430395200)
      counts = Hash.new(0)
      @eight_four_matches.each { |player_match| counts[player_match.hero_id] += 1 }
      @eight_four_hero_id = counts.sort_by{|x,y| y}.last[0]
      HeroID::HERO_HASH[:result][:heroes].each do |hero|
        if @eight_four_hero_id == hero[:id]
          @eight_four_hero = hero[:name]
        end
      end
      render "players/show"
    end
  end

  def vote
    @submission = Submission.find(params[:id])

    respond_to do |format|
      if @submission.liked_by current_user
        format.json {
          render json: {
            id: @submission.id,
            size: @submission.votes_for.size,
          }
        }
      else
        render json: {}
      end
    end
  end

  def unvote
    @submission = Submission.find(params[:id])

    respond_to do |format|
      if @submission.unliked_by current_user
        format.json {
          render json: {
            id: @submission.id,
            size: @submission.votes_for.size,
          }
        }
      else
        render json: {}
      end
    end
  end

  def edit
    @submission = Submission.find(params[:id])
    unless @submission.creator?(current_user)
      flash[:notice] = "You must be the creator of the submission to edit!"
      redirect_to player_path(@submission.player_id)
    end
  end

  def update
    @submission = Submission.find(params[:id])
    if @submission.update_attributes(submission_params)
      flash[:success] = 'Your changes have been saved!'
      redirect_to player_path(@submission.player)
    else
      flash[:notice] = @submission.errors.full_messages.join(". ")
      render :edit
    end
  end

  def destroy
    @submission = Submission.find(params[:id]).destroy
    flash[:notice] = "Your submission has been deleted"
    redirect_to player_path(@player.account_id)
  end

  private

  def set_current_models
    @player = Player.find(params[:player_id])
    @submission = Submission.find(params[:id])
  end

  def submission_params
    params.require(:submission).permit(
      :content,
      :sub_in_review,
      :user_id,
      :player_id
    )
  end
end
