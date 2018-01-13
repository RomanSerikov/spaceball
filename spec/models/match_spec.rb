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
      expect(game.errors.messages[:team_a]).to include("teams can't be the same")
    end
  end
end
