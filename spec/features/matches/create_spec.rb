require 'features_helper'

feature 'Create match', %q{
  In order to host tournament
  As an administrator
  I want to be able to create match
} do

  given!(:tournament) { create(:tournament) }
  given(:obj_path) { new_admin_tournament_match_path(tournament) }

  it_behaves_like 'Restricted access'

  describe 'Administrator' do
    given(:admin) { create(:user, admin: true) }
    given!(:team_a) { create(:team, title: 'Arsenal') }
    given!(:team_b) { create(:team, title: 'Barcelona') }

    background do
      tournament.teams << team_a
      tournament.teams << team_b
      sign_in admin
      visit obj_path
    end

    scenario 'creates match with valid parameters' do
      fill_in 'match_start_date', with: '2018/02/10'
      fill_in 'match_start_time', with: '16:00'
      find('#match_team_a_id').find(:xpath, 'option[2]').select_option
      find('#match_team_b_id').find(:xpath, 'option[3]').select_option
      click_on 'Create'

      expect(page).to have_content 'Match was successfully created'
      expect(page).to have_content '2018-02-10'
      expect(page).to have_content '16:00'
      expect(page).to have_content 'Arsenal'
      expect(page).to have_content 'Barcelona'
    end

    scenario 'tries to create match with invalid parameters' do
      fill_in 'match_start_date', with: nil
      fill_in 'match_start_time', with: nil
      click_on 'Create'

      expect(page).to have_content 'Start date can\'t be blank'
      expect(page).to have_content 'Start time can\'t be blank'
      expect(page).to have_content 'Team a must exist'
      expect(page).to have_content 'Team b must exist'
      expect(page).to have_content 'Teams can\'t be the same'
    end
  end
end
