FactoryBot.define do
  factory :calendar_day do
    calendar { nil }
    day_number { 1 }
    status { 1 }
    donor { nil }
    selected_at { "2024-12-23 10:25:11" }
    purchased_at { "2024-12-23 10:25:11" }
  end
end
