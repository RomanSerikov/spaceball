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
end
