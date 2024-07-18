FactoryBot.define do
  factory :note do
    title { Faker::Name }
    content { Faker::Quotes::Shakespeare }
  end
end
