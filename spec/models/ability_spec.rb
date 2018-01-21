require 'rails_helper'

describe Ability do
  subject(:ability) { Ability.new(user) }

  describe 'for guest' do
    let(:user) { nil }

    it { should be_able_to :read, :all }
    it { should_not be_able_to :manage, :all }
  end

  describe 'for user' do
    let(:user) { create(:user) }

    it { should be_able_to :read, :all }
    it { should_not be_able_to :manage, :all }
  end

  describe 'for captain' do
    let(:team) { create(:team, title: 'Barcelona') }
    let(:user) { create(:user, captain: true, team: team) }

    it { should be_able_to :read, :all }
    it { should be_able_to :create, Player, team: user.team }
    it { should be_able_to :update, Match }
  end

  describe 'for admin' do
    let(:user) { create(:user, admin: true) }

    it { should be_able_to :manage, :all }
  end
end
