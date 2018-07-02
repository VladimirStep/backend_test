FactoryBot.define do
  factory :publisher do
    name { Faker::Book.publisher }
  end
end
