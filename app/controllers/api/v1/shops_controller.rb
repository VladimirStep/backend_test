module Api
  module V1
    class ShopsController < ApplicationController
      def index
        publisher = Publisher.find(params[:publisher_id])
        shops = Shop.by_sold_publisher_books(publisher.id)
        # Neil's solution
        # shops = Shop.includes(books: :stock_records).order('stock_records.sold DESC').where(books: { publisher: publisher })
        render json: shops, root: 'shops'
      end
    end
  end
end