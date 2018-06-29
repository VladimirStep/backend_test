class Book < ApplicationRecord
  belongs_to :publisher
  has_many :stock_records
  has_many :shops, through: :stock_records
end
