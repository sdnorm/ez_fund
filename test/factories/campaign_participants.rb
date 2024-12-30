FactoryBot.define do
  factory :campaign_participant do
    campaign { nil }
    champion_assignment { nil }
    first_name { "MyString" }
    last_name { "MyString" }
    unique_code { "MyString" }
  end
end
