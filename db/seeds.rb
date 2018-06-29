# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

3.times do |index|
  Publisher.create(name: "Publisher_#{index}")
end

4.times do |index|
  Shop.create(name: "Shop_#{index}")
end

Publisher.all.each do |publisher|
  3.times do |index|
    publisher.books.create(title: "Book_#{index} of #{publisher.name}")
  end
end

Book.all.each do |book|
  shop_ids = Shop.ids
  3.times do
    shop_id = shop_ids.sample
    shop_ids -= [shop_id]
    StockRecord.create(book_id: book.id,
                       shop_id: shop_id,
                       in_stock: rand(3),
                       sold: rand(10))
  end
end