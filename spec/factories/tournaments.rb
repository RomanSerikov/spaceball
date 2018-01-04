FactoryBot.define do
  factory :tournament do
    title 'SuperBowl'
    start_date Time.now
    end_date 2.months.from_now
  end
end
