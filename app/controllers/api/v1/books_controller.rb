module Api
  module V1
    class BooksController < ApplicationController
      def sell
        stock = StockRecord.find_by!(book_id: params[:id], shop_id: params[:shop_id])
        if stock.sell_book(number_of_copies)
          head :no_content
        else
          render json: { error: stock.errors.full_messages }, status: 422
        end
      end

      private

      def number_of_copies
        params[:book].try(:[], :copies)
      end
    end
  end
end