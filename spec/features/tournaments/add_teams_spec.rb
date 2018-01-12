require 'features_helper'

feature 'Add teams to tournament', %q{
  In order to host a tournament
  As an administrator
  I want to be able to add teams to the tournament
} do

  describe 'Administrator' do
    given(:admin) { create(:user, admin: true) }
    given(:tournament) { create(:tournament) }
    given!(:team_a) { create(:team, title: 'Arsenal') }
    given!(:team_b) { create(:team, title: 'Barcelona') }

    background do
      sign_in admin
      visit admin_tournament_path(tournament)
    end

    scenario 'can add teams to tournament', js: true do
      click_on 'Barcelona'

      within '.participants' do
        expect(page).to have_content 'Barcelona'
      end

      within '.candidates' do
        expect(page).to have_content 'Arsenal'
      end
    end
  end
end
