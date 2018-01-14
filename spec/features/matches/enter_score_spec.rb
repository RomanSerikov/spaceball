require 'features_helper'

feature 'Enter match score', %q{
  In order to get tournament table
  As an administrator
  I want to be able to enter score
} do

  given(:tournament) { create(:tournament) }
  given(:team_a) { create(:team, title: 'Arsenal') }
  given(:team_b) { create(:team, title: 'Barcelona') }
  given(:game) { create(:match, tournament: tournament, team_a: team_a, team_b: team_b) }
  given(:obj_path) { admin_match_path(game) }

  it_behaves_like 'Restricted access'

  describe 'Administrator' do
    given(:admin) { create(:user, admin: true) }
    
    background do
      sign_in admin
      visit obj_path
    end

    scenario 'enters match score with valid parameters' do
      fill_in "match_team_a_goals", with: 5
      fill_in "match_team_b_goals", with: 0
      click_on 'Save match score'

      expect(page).to have_content 'Match was successfully updated.'
      expect(page).to have_content '5 : 0'
    end

    scenario 'tries to enter match score with invalid parameters' do
      fill_in "match_team_a_goals", with: -1
      fill_in "match_team_b_goals", with: 100
      click_on 'Save match score'

      expect(page).to have_content 'Score must be in range 0..50.'
    end
  end
end
