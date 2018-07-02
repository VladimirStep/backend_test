class Book < ApplicationRecord
  belongs_to :publisher
  has_many :stock_records
  has_many :shops, through: :stock_records

  def copies_in_stock
    stock_records.find_by(shop_id: shop_id)&.in_stock
  end
end
