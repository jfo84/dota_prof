require 'rails_helper'

feature 'user creates a submission' do

  # Acceptance Criteria
  # [x] User must submit content
  # [x] If they submit incomplete information, then they get an error and the
  #     form page rerenders
  # [x] If there's more than one review, show a list

  scenario 'authenticated user visits attempts to add a review' do
    player = FactoryGirl.create(:player)
    user = player.user
    sign_in(user)

    visit player_path(player.account_id)

    expect(page).to have_content("Content")
  end

  scenario 'unauthenticated user attempts to add a review' do
    player = FactoryGirl.create(:player)

    visit player_path(player.account_id)

    fill_in "Content", with: "I love the best player!"

    click_link "Submit"

    expect(page).to have_content("Log in")
  end

  scenario 'user submits new review for a player' do
    player = FactoryGirl.create(:player)
    user = player.user
    sign_in(user)

    first(:link, player.name).click

    click_link 'Write a Review'

    select 'Great - 5', from: 'Rating'
    fill_in "Description", with: "Best player ever"
    click_button "Submit"

    expect(page).to have_content("Best player ever")
  end

  scenario 'user submits incomplete information for a review for a player' do
    player = FactoryGirl.create(:player)
    user = player.user
    sign_in(user)

    first(:link, player.name).click

    click_link 'Write a Review'

    click_button "Submit"
    expect(page).to have_content("can\'t be blank")
  end

  scenario 'users submits two reviews for one player' do
    player = FactoryGirl.create(:player)
    user = FactoryGirl.create(:user)

    visit root_path

    login_as(user, scope: :user, run_callbacks: false)

    visit new_player_review_path(player)

    select 'Great - 5', from: 'Rating'
    fill_in "Description", with: "Best player ever"
    click_button "Submit"

    visit new_player_review_path(player)

    select 'Great - 5', from: 'Rating'
    fill_in "Description", with: "Best player ever"
    click_button "Submit"

    expect(page).to have_content("User can only submit one review for a player.")
  end

  scenario 'user views multiple reviews on playeres show page' do
    player = FactoryGirl.create(:player)
    review1 = FactoryGirl.create(:review, player: player)
    review2 = FactoryGirl.create(:review, player: player)

    visit player_path(player)

    expect(page).to have_content(review1.description)
    expect(page).to have_content(review2.description)
  end
end
