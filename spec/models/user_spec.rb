require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ActiveRecord associations' do
    it { should belong_to(:team) }
    it { should have_db_column(:team_id) }
  end
end
