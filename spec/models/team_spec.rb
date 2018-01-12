require 'rails_helper'

RSpec.describe Team, type: :model do
  it 'has a valid factory' do
    expect(build(:team)).to be_valid
  end

  describe 'ActiveRecord associations' do
    it { should have_many(:tournaments_teams) }
    it { should have_many(:tournaments).through(:tournaments_teams) }
    it { should have_many(:players) }
  end
  
  describe 'ActiveModel validations' do
    it { should validate_presence_of(:title) }
  end

  describe '.not_participating' do
    let!(:team_1) { create(:team) }
    let!(:team_2) { create(:team) }
    let!(:tournament) { create(:tournament) }

    it 'returns list of teams not participation in tournament' do
      tournament.teams << team_1

      expect(Team.not_participating(tournament)).to eq([team_2])
    end
  end
end
