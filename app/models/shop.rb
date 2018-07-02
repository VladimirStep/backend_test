class Shop < ApplicationRecord
  has_many :stock_records
  has_many :books, through: :stock_records

  def self.by_sold_publisher_books(publisher_id)
    sql = <<-SQL.squish
      SELECT
        shops.*,
        rating.books_sold_count AS books_sold_count,
        #{publisher_id} AS publisher_id
      FROM
        shops
      INNER JOIN (
        SELECT
          shop_id,
          SUM(sold) AS books_sold_count,
          SUM(in_stock) AS books_in_stock_count
        FROM
          stock_records
        INNER JOIN books ON books.id = stock_records.book_id
        INNER JOIN publishers ON publishers.id = books.publisher_id
        WHERE publishers.id = #{publisher_id}
        GROUP BY
          shop_id
      ) rating ON rating.shop_id = shops.id
      WHERE rating.books_in_stock_count > 0
      ORDER BY
        rating.books_sold_count DESC;
    SQL
    self.find_by_sql(sql)
  end

  def publisher_books
    books.select("books.*, #{id} AS shop_id ")
        .where(publisher_id: publisher_id)
        .where('stock_records.in_stock > ?', 0)
  end
end
