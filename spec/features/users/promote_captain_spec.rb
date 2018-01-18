require 'features_helper'

feature 'Change user status to captain', %q{
  In order to simplify entering match results
  As an administrator
  I want to be able to promote user to captain
} do

  given(:obj_path) { admin_users_path } 

  it_behaves_like 'Restricted access'

  describe 'Administrator' do
    given(:admin) { create(:user, admin: true) }
    given!(:user) { create(:user, email: 'user@test.com') }
    given!(:cap) { create(:user, email: 'jack@sparrow.com', captain: true) }

    background do
      sign_in admin
      visit obj_path
    end

    scenario 'changes user status to captain' do
      click_on 'user@test.com'
      click_on 'Edit user info'
      check 'Captain'
      click_on 'Save'

      expect(page).to have_content 'User was successfully updated'
      expect(page).to have_content 'User is captain!'
    end

    scenario 'changes user status to simple user' do
      click_on 'jack@sparrow.com'
      click_on 'Edit user info'
      uncheck 'Captain'
      click_on 'Save'

      expect(page).to have_content 'User was successfully updated'
      expect(page).to have_content 'This is just a simple user.'
    end
  end
end
