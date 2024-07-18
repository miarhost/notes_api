FactoryBot.define do
  factory :note do
    title { Faker::Name.name }
    content { Faker::Quotes::Shakespeare.hamlet_quote }
  end
end
