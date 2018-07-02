class ShopSerializer < ActiveModel::Serializer
  attributes :id, :name, :books_sold_count

  has_many :books_in_stock, serializer: BookSerializer do
    object.publisher_books
  end
end
