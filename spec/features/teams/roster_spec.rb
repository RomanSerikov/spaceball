require 'features_helper'

feature 'Display team roster', %q{
  In order to satisfy my own curiosity
  As a guest
  I want to see teams roster
} do
  given(:team) { create(:team) }
  given!(:forward) { create(:player, first_name: 'Lionel', last_name: 'Messi', team: team) }
  given!(:goalkeeper) { create(:player, first_name: 'Gianluigi', last_name: 'Buffon', team: team) }

  scenario 'Guest sees teams roster' do
    visit team_path(team)

    expect(page).to have_content('Team roster')
    expect(page).to have_content forward.first_name
    expect(page).to have_content forward.last_name
    expect(page).to have_content goalkeeper.first_name
    expect(page).to have_content goalkeeper.last_name
  end
end
