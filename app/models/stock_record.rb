class StockRecord < ApplicationRecord
  belongs_to :book
  belongs_to :shop

  def sell_book(copies = nil)
    unless copies&.is_a?(Integer)
      errors[:base] << 'Number of copies is incorrect'
      return false
    end
    if copies > in_stock
      errors[:base] << 'Out of stock'
      return false
    end
    update_attributes(
      in_stock: in_stock - copies,
      sold: sold + copies
    )
  end
end
