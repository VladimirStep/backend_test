class ShopSerializer < ActiveModel::Serializer
  attributes :id, :name, :books_sold_count

  has_many :books_in_stock, serializer: BookSerializer

  def books_in_stock
    object.publisher_books
  end
end
