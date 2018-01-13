FactoryBot.define do
  factory :match do
    start_date Time.now
    start_time Time.now
    tournament
    association :team_a, factory: :team
    association :team_b, factory: :team
  end
end
