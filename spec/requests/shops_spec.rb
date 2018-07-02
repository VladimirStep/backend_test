require 'rails_helper'

RSpec.describe 'Requests to ShopsController', type: :request do
  let(:publisher) { create(:publisher) }
  let(:other_publisher) { create(:publisher) }
  let(:book_1) { create(:book, publisher: publisher) }
  let(:book_2) { create(:book, publisher: publisher) }
  let(:book_3) { create(:book, publisher: publisher) }
  let(:other_book_1) { create(:book, publisher: other_publisher) }
  let(:other_book_2) { create(:book, publisher: other_publisher) }
  let(:shop_1) { create(:shop) }
  let(:shop_2) { create(:shop) }
  let(:shop_3) { create(:shop) }
  let(:shop_4) { create(:shop) }
  let(:other_shop) { create(:shop) }

  describe 'list of shops' do
    before do
      [book_1, book_3, other_book_1, other_book_2].each do |book|
        create(:stock_record, shop: shop_1, book: book, sold: 3, in_stock: 2)
      end
      create(:stock_record, shop: shop_1, book: book_2, sold: 3, in_stock: 0)

      [book_2, book_3, other_book_1, other_book_2].each do |book|
        create(:stock_record, shop: shop_2, book: book, sold: 5, in_stock: 1)
      end

      [book_1, book_2, book_3].each do |book|
        create(:stock_record, shop: shop_3, book: book, sold: 1, in_stock: 1)
      end

      [book_1, book_2, book_3].each do |book|
        create(:stock_record, shop: shop_4, book: book, sold: 7, in_stock: 0)
      end

      [other_book_1, other_book_2].each do |book|
        create(:stock_record, shop: other_shop, book: book, sold: 9, in_stock: 1)
      end

      get "/api/v1/publishers/#{publisher.id}/shops", headers: json_headers
    end

    it_behaves_like 'success response'

    it 'contains all shops with publisher books' do
      expect(get_ids(json[:shops])).to include(shop_1.id, shop_2.id, shop_3.id)
    end

    it 'does not contain shops without publisher books' do
      expect(get_ids(json[:shops])).not_to include(shop_4.id, other_shop.id)
    end

    it 'ordered by the number of books sold' do
      expect(get_ids(json[:shops])).to eq([shop_2.id, shop_1.id, shop_3.id])
    end

    describe 'each shop in the list' do
      before do
        @shop_1_books = json[:shops].find { |obj| obj[:id] == shop_1.id }[:books_in_stock]
        @shop_2_books = json[:shops].find { |obj| obj[:id] == shop_2.id }[:books_in_stock]
        @shop_3_books = json[:shops].find { |obj| obj[:id] == shop_3.id }[:books_in_stock]
      end

      it 'includes books of current publisher' do
        expect(get_ids(@shop_1_books)).to include(book_1.id, book_3.id)
        expect(get_ids(@shop_2_books)).to include(book_2.id, book_3.id)
        expect(get_ids(@shop_3_books)).to include(book_1.id, book_2.id, book_3.id)
      end

      it 'does not include books of other publisher' do
        expect(get_ids(@shop_1_books)).not_to include(other_book_1.id, other_book_2.id)
        expect(get_ids(@shop_2_books)).not_to include(other_book_1.id, other_book_2.id)
      end

      it 'does not include publisher books that are out of stock' do
        expect(get_ids(@shop_1_books)).not_to include(book_2.id)
      end
    end
  end
end
