require 'rails_helper'

feature 'user creates a submission' do

  scenario 'authenticated user visits player' do
    player = FactoryGirl.create(:player)
    FactoryGirl.create(:player_match, player: player)
    user = FactoryGirl.create(:user)
    sign_in(user)

    visit player_path(player.account_id)

    expect(page).to have_content("Content")
  end
end
