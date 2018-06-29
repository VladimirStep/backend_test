class Book < ApplicationRecord
  belongs_to :publisher
  has_many :stock_records
  has_many :shops, through: :stock_records

  def copies_in_stock
    stock_records.where('in_stock > ?', 0).find_by(book_id: id).in_stock
  end
end
