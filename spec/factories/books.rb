FactoryBot.define do
  factory :book do
    title { Faker::Book.title }
    publisher
  end
end
