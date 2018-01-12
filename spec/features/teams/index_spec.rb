require 'features_helper'

feature 'Display teams list', %q{
  In order to estimate favourite team chances
  As a guest
  I want to see all teams in the tournament
} do

  given!(:teams) { create_list(:team, 3) }

  scenario 'Guest sees teams list' do
    visit teams_path

    expect(page).to have_content('MyTeamName', count: 3)
  end
end
