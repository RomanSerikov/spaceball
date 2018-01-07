require 'rails_helper'

RSpec.describe Tournament, type: :model do
  it 'has a valid factory' do
    expect(build(:tournament)).to be_valid
  end

  describe 'ActiveRecord associations' do
    it { should have_many(:tournaments_teams) }
    it { should have_many(:teams).through(:tournaments_teams) }
  end

  describe 'ActiveModel validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:start_date) }
    it { should validate_presence_of(:end_date) }
  end

  describe '#add_team' do
    let(:tournament) { create(:tournament) }
    let(:team_1) { create(:team) }

    it 'adds team to tournament' do
      tournament.add_team(team_1.id)

      expect(tournament.teams).to eq [team_1]
    end
  end

  describe '#remove_team' do
    let(:tournament) { create(:tournament) }
    let(:team_1) { create(:team) }
    let(:team_2) { create(:team) }

    it 'removes team from tournament' do
      tournament.teams << team_1 << team_2
      tournament.remove_team(team_1.id)

      expect(tournament.teams).to eq [team_2]
    end
  end
end
