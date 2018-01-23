require 'features_helper'

feature 'Create player', %q{
  In order to increase users interest to teams and tournament
  As a captain
  I want to be able to add players to my team
} do

  describe 'Captain' do
    given(:team) { create(:team, title: 'Barcelona') }
    given(:captain) { create(:user, captain: true, team: team) }

    background do
      sign_in captain
      visit team_path(team)
      click_on 'Add player'
    end

    scenario 'creates player with valid parameters' do
      fill_in 'First name', with: 'Lionel'
      fill_in 'Last name', with: 'Messi'
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
    end
  end
end
