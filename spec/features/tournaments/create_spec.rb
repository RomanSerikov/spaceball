require 'features_helper'

feature 'Create tournament', %q{
  In order to separate different tournaments history
  As an administrator
  I want to be able to create tournament
} do

  describe 'Administrator' do
    given(:admin) { create(:user, admin: true) }

    background do
      sign_in admin
      visit new_tournament_path
    end

    scenario 'creates tournament with valid parameters' do
      fill_in 'Title', with: 'Summer Superball'
      fill_in 'tournament_start_date', with: '2018/02/01'
      fill_in 'tournament_end_date', with: '2018/04/01'
      click_on 'Create'

      expect(page).to have_content 'Tournament was successfully created'
      expect(page).to have_content 'Summer Superball'
      expect(page).to have_content '2018-02-01'
      expect(page).to have_content '2018-04-01'
    end

    scenario 'tries to create tournament with invalid parameters' do
      fill_in 'Title', with: nil
      fill_in 'tournament_start_date', with: nil
      fill_in 'tournament_end_date', with: nil
      click_on 'Create'

      expect(page).to have_content 'Title can\'t be blank'
      expect(page).to have_content 'Start date can\'t be blank'
      expect(page).to have_content 'End date can\'t be blank'
    end
  end

  describe 'Not an administrator' do
    given(:alice) { create(:user) }

    scenario 'user tries to create player' do
      sign_in alice
      visit new_tournament_path

      expect(page).to have_content 'You are not authorized to access this page.'
    end

    scenario 'guest tries to create tournament' do
      visit new_tournament_path

      expect(page).to have_content 'You need to sign in or sign up before continuing.'
    end
  end
end
