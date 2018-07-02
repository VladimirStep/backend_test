FactoryBot.define do
  factory :stock_record do
    in_stock { rand(10) }
    sold { rand(10) }
    book
    shop
  end
end