require 'rails_helper'

RSpec.describe 'Requests to BooksController', type: :request do
  let(:publisher) { create(:publisher) }
  let(:book) { create(:book, publisher: publisher) }
  let(:shop) { create(:shop) }

  describe 'sell book endpoint' do
    let(:request_body) { { book: { copies: 2 } } }

    context 'when there is enough copies in stock' do
      let!(:stock) { create(:stock_record, shop: shop, book: book, sold: 3, in_stock: 3) }

      before do
        post "/api/v1/shops/#{shop.id}/books/#{book.id}/sell",
             params: request_body.to_json,
             headers: json_headers
      end

      it 'process request and change records' do
        expect(response).to have_http_status(:no_content)
        stock.reload
        expect(stock.sold).to eq(5)
        expect(stock.in_stock).to eq(1)
      end
    end

    context 'when there is not enough copies in stock' do
      let!(:stock) { create(:stock_record, shop: shop, book: book, sold: 3, in_stock: 1) }

      before do
        post "/api/v1/shops/#{shop.id}/books/#{book.id}/sell",
             params: request_body.to_json,
             headers: json_headers
      end

      it 'process request and change records' do
        expect(response).to have_http_status(:unprocessable_entity)
        expect(json).to eq(error: 'Out of stock')
        stock.reload
        expect(stock.sold).to eq(3)
        expect(stock.in_stock).to eq(1)
      end
    end
  end
end
