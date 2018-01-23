require 'features_helper'

feature 'Assign captain to team', %q{
  In order to give user captain's access
  As an administrator
  I want to be able to assign team's captain
} do

  given(:captain) { create(:user, captain: true) }
  given(:obj_path) { edit_admin_user_path(captain) }

  it_behaves_like 'Restricted access'

  describe 'Administrator' do
    given(:admin) { create(:user, admin: true) }
    given!(:team) { create(:team, title: 'Barcelona') }

    background do
      sign_in admin
      visit obj_path
    end

    scenario 'assigns user to team' do
      find('#user_team_id').find(:xpath, 'option[2]').select_option
      click_on 'Save'

      expect(page).to have_content 'User was successfully updated'
      expect(page).to have_content 'Team: Barcelona'
    end
  end
end
