module Api
  module V1
    class BooksController < ApplicationController
      def sell
        stock = StockRecord.find_by!(book_id: params[:id], shop_id: params[:shop_id])
        SellBook.new(stock, number_of_copies).call
        head :no_content
      end

      private

      def number_of_copies
        params[:book].try(:[], :copies)
      end
    end
  end
end