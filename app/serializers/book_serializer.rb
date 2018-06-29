class BookSerializer < ActiveModel::Serializer
  attributes :id, :title, :copies_in_stock
end
