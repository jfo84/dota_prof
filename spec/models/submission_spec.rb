require 'rails_helper'

feature 'user creates a submission' do

  # Acceptance Criteria
  # [x] User must submit content
  # [x] If they submit incomplete information, then they get
  #      an error and the form page rerenders
  # [x] If there's more than one submission, show a list with
  #      highest score first

  scenario 'unauthenticated user attempts to add a review' do
    player = FactoryGirl.create(:player)
    FactoryGirl.create(:player_match, player: player)

    visit player_path(player.account_id)

    fill_in "Content", with: "I love the best player!"
    click_button "Submit"

    expect(page).to have_content("Log in")
  end

  scenario 'user submits new submission for a player' do
    player = FactoryGirl.create(:player)
    FactoryGirl.create(:player_match, player: player)
    user = FactoryGirl.create(:user)
    sign_in(user)

    visit player_path(player.account_id)

    fill_in "Content", with: "I love the best player!"
    click_button "Submit"

    expect(page).to have_content("Best Player")
  end

  scenario 'user submits incomplete information for a review for a player' do
    player = FactoryGirl.create(:player)
    FactoryGirl.create(:player_match, player: player)
    user = FactoryGirl.create(:user)
    sign_in(user)

    visit player_path(player.account_id)

    click_button "Submit"
    expect(page).to have_content("can\'t be blank")
  end

  scenario 'user views multiple submissions on players show page' do
    player = FactoryGirl.create(:player)
    FactoryGirl.create(:player_match, player: player)
    submission1 = FactoryGirl.create(:submission, player: player)
    submission2 = FactoryGirl.create(:submission, player: player)

    visit player_path(player.account_id)

    expect(page).to have_content(submission1.content)
    expect(page).to have_content(submission2.content)
  end
end
