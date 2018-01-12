require 'rails_helper'

RSpec.describe TournamentsTeam, type: :model do
  describe 'ActiveRecord associations' do
    it { should belong_to(:tournament) }
    it { should belong_to(:team) }
  end
end
