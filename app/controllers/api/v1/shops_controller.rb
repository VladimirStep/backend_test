module Api
  module V1
    class ShopsController < ApplicationController
      def index
        publisher = Publisher.find(params[:publisher_id])
        shops = Shop.by_sold_publisher_books(publisher.id)
        render json: shops, root: 'shops'
      end
    end
  end
end