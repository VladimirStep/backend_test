class CreateStockRecords < ActiveRecord::Migration[5.1]
  def change
    create_table :stock_records do |t|
      t.references :book, foreign_key: true
      t.references :shop, foreign_key: true
      t.integer :in_stock
      t.integer :sold

      t.timestamps
    end
  end
end
