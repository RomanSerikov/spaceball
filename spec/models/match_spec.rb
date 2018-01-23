require 'rails_helper'

RSpec.describe Match, type: :model do
  it 'has a valid factory' do
    expect(build(:match)).to be_valid
  end

  describe 'ActiveRecord associations' do
    it { should belong_to(:tournament) }
    it { should have_db_column(:tournament_id) }
    it { should belong_to(:team_a).class_name('Team') }
    it { should have_db_column(:team_a_id) }
    it { should belong_to(:team_b).class_name('Team') }
    it { should have_db_column(:team_b_id) }
    it { should belong_to(:winner).class_name('Team') }
    it { should have_db_column(:winner_id) }
    it { should belong_to(:loser).class_name('Team') }
    it { should have_db_column(:loser_id) }
  end

  describe 'ActiveModel validations' do
    it { should validate_presence_of(:start_date) }
    it { should validate_presence_of(:start_time) }
    it { should validate_inclusion_of(:team_a_goals).in_range(0..50) }
    it { should validate_inclusion_of(:team_b_goals).in_range(0..50) }

    let(:team) { build(:team) }
    let(:game) { build(:match, team_a: team, team_b: team) }

    it 'validates that teams are different' do
      expect(game).to be_invalid
      expect(game.errors[:base]).to include("Teams can't be the same")
    end
  end

  describe '#title' do
    let!(:team_1) { create(:team, title: 'Arsenal') } 
    let!(:team_2) { create(:team, title: 'Barcelona') }
    let!(:game) { create(:match, team_a: team_1, team_b: team_2) }

    it 'returns title that contains both teams title' do
      expect(game.title).to eq "#{team_1.title} - #{team_2.title}"
    end
  end
end
