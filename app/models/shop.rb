class Shop < ApplicationRecord
  has_many :stock_records
  has_many :books, through: :stock_records
end
