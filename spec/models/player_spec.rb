require 'rails_helper'

RSpec.describe Player, type: :model do
  it 'has a valid factory' do
    expect(build(:player)).to be_valid
  end

  describe 'ActiveRecord associations' do
    it { should belong_to(:team) }
    it { should have_db_column(:team_id) }
  end

  describe 'ActiveModel validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
  end
end
