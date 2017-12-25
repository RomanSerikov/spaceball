require 'features_helper'

feature 'Create team', %q{
  In order to add tournament participants
  As an administrator
  I want to be able to create team
} do

  describe 'Administrator' do
    given(:admin) { create(:user, admin: true) }

    background do
      sign_in admin
      visit new_team_path
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

  describe 'Not an administrator' do
    given(:alice) { create(:user) }

    scenario 'user tries to create team' do
      sign_in alice
      visit new_team_path

      expect(page).to have_content 'You are not authorized to access this page.'
    end

    scenario 'guest tries to create team' do
      visit new_team_path

      expect(page).to have_content 'You need to sign in or sign up before continuing.'
    end
  end
end
