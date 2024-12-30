FactoryBot.define do
  factory :purchase do
    donor { nil }
    amount { "9.99" }
    stripe_payment_intent_id { "MyString" }
  end
end
