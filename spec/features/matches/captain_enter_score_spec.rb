require 'features_helper'

feature 'Enter match score', %q{
  In order to update tournament table faster
  As a captain
  I want to be able to enter score for my team
} do

  given(:tournament) { create(:tournament) }
  given(:team_a) { create(:team, title: 'Arsenal') }
  given(:team_b) { create(:team, title: 'Barcelona') }
  given(:team_c) { create(:team, title: 'Real Madrid') }
  given(:game) { create(:match, tournament: tournament, team_a: team_a, team_b: team_b) }
  given(:captain) { create(:user, captain: true, team: team_a) }

  describe 'Captain with own team in match' do
    background do
      sign_in captain
      visit match_path(game)
    end

    scenario 'enters match score with valid parameters' do
      fill_in "match_team_a_goals", with: 5
      fill_in "match_team_b_goals", with: 0
      click_on 'Save match score'

      expect(page).to have_content 'Thank you. Score will be updated after administartor verify it.'
    end

    scenario 'tries to enter match score with invalid parameters' do
      fill_in "match_team_a_goals", with: -1
      fill_in "match_team_b_goals", with: 100
      click_on 'Save match score'

      expect(page).to have_content 'Score must be in range 0..50.'
    end
  end

  describe 'Captain with another team in match' do
    given(:game_2) { create(:match, tournament: tournament, team_a: team_b, team_b: team_c) }

    scenario 'have no fields to enter score' do
      sign_in captain
      visit match_path(game_2)

      expect(page).to have_content 'Match haven\'t played yet.'
      expect(page).to have_no_content 'Save match score'
      expect(page).to have_no_field 'match_team_a_goals'
      expect(page).to have_no_field 'match_team_b_goals'
    end
  end
end
