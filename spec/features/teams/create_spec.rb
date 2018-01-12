require 'features_helper'

feature 'Create team', %q{
  In order to add tournament participants
  As an administrator
  I want to be able to create team
} do

  given(:obj_path) { new_admin_team_path }

  it_behaves_like 'Restricted access'

  describe 'Administrator' do
    given(:admin) { create(:user, admin: true) }

    background do
      sign_in admin
      visit obj_path
    end

    scenario 'creates team with valid parameters' do
      fill_in 'Title', with: 'Test team'
      fill_in 'Description', with: 'supa dupa team'
      click_on 'Create'

      expect(page).to have_content 'Team was successfully created'
      expect(page).to have_content 'Test team'
      expect(page).to have_content 'supa dupa team'
    end

    scenario 'tries to create team without name' do
      fill_in 'Title', with: nil
      click_on 'Create'

      expect(page).to have_content 'Title can\'t be blank'
    end
  end
end
