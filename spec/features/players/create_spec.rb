require 'rails_helper'

feature 'Create player', %q{
  In order to increase users interest to teams and tournament
  As an administrator
  I want to be able to add players to teams
} do

  describe 'Administrator' do
    given(:admin) { create(:user, admin: true) }
    given!(:team) { create(:team, title: 'Barcelona') }

    background do
      sign_in admin
      visit new_player_path
    end

    scenario 'creates player with valid parameters' do
      fill_in 'First name', with: 'Lionel'
      fill_in 'Last name', with: 'Messi'
      find('#player_team_id').find(:xpath, 'option[2]').select_option
      click_on 'Create'

      expect(page).to have_content 'Player was successfully created'
      expect(page).to have_content 'Lionel'
      expect(page).to have_content 'Messi'
      expect(page).to have_content 'Barcelona'
    end

    scenario 'tries to create player with invalid parameters' do
      fill_in 'First name', with: nil
      fill_in 'Last name', with: nil
      click_on 'Create'

      expect(page).to have_content 'First name can\'t be blank'
      expect(page).to have_content 'Last name can\'t be blank'
      expect(page).to have_content 'Team must exist'
    end
  end

  describe 'Not an administrator' do
    given(:alice) { create(:user) }

    scenario 'user tries to create player' do
      sign_in alice
      visit new_player_path

      expect(page).to have_content 'You are not authorized to access this page.'
    end

    scenario 'guest tries to create player' do
      visit new_player_path

      expect(page).to have_content 'You need to sign in or sign up before continuing.'
    end
  end
end
