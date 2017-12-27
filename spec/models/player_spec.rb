require 'rails_helper'

RSpec.describe Player, type: :model do
  it { should belong_to(:team) }
  it { should have_db_column(:team_id) }

  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
end
