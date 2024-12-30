FactoryBot.define do
  factory :campaign do
    organization { nil }
    name { "MyString" }
    start_date { "2024-12-23" }
    end_date { "2024-12-23" }
    status { 1 }
    settings { "" }
  end
end
