require 'features_helper'

feature 'Remove teams from tournament', %q{
  In order to host a tournament
  As an administrator
  I want to be able to remove teams from the tournament
} do

  describe 'Administrator' do
    given(:admin) { create(:user, admin: true) }
    given(:tournament) { create(:tournament) }
    given!(:team_a) { create(:team, title: 'Arsenal') }
    given!(:team_b) { create(:team, title: 'Barcelona') }

    background do
      sign_in admin
      tournament.add_team(team_a.id)
      tournament.add_team(team_b.id)
      visit tournament_path(tournament)
    end

    scenario 'can remove one team from tournament', js: true do
      click_on 'Arsenal'

      within '.participants' do
        expect(page).to have_content 'Barcelona'
      end

      within '.candidates' do
        expect(page).to have_content 'Arsenal'
      end
    end

    scenario 'can remove all teams from tournament', js: true do
      click_on 'Arsenal'
      click_on 'Barcelona'

      within '.candidates' do
        expect(page).to have_content 'Arsenal'
        expect(page).to have_content 'Barcelona'
      end

      expect(page).to have_content 'No teams in this tournament yet.'
    end
  end
end
