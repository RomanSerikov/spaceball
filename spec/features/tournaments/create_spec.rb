require 'features_helper'

feature 'Create tournament', %q{
  In order to separate different tournaments history
  As an administrator
  I want to be able to create tournament
} do

  given(:obj_path) { new_admin_tournament_path }

  it_behaves_like 'Restricted access'

  describe 'Administrator' do
    given(:admin) { create(:user, admin: true) }

    background do
      sign_in admin
      visit obj_path
    end

    scenario 'creates tournament with valid parameters' do
      fill_in 'Title', with: 'Summer Superball'
      fill_in 'tournament_start_date', with: '2018/02/01'
      fill_in 'tournament_end_date', with: '2018/04/01'
      click_on 'Create'

      expect(page).to have_content 'Tournament was successfully created'
      expect(page).to have_content 'Summer Superball'
      expect(page).to have_content '01.02.18'
      expect(page).to have_content '01.04.18'
    end

    scenario 'tries to create tournament with invalid parameters' do
      fill_in 'Title', with: nil
      fill_in 'tournament_start_date', with: nil
      fill_in 'tournament_end_date', with: nil
      click_on 'Create'

      expect(page).to have_content 'Title can\'t be blank'
      expect(page).to have_content 'Start date can\'t be blank'
      expect(page).to have_content 'End date can\'t be blank'
    end
  end
end
