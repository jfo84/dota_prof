class SubmissionsController < ApplicationController
  before_action :authorize_user
  before_action :set_current_models, only: [:edit, :update, :destroy]

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

  def authorize_user
    if !user_signed_in? && current_user != Submission.find(params[:id]).user
      raise ActionController::RoutingError.new("Not Found")
    end
  end
end
