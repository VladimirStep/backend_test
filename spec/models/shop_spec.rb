require 'rails_helper'

RSpec.describe Shop, type: :model do
  it 'has valid factory' do
    expect(build(:shop)).to be_valid
  end

  let(:shop) { build(:shop) }
  subject { shop }

  describe 'database' do
    it { should have_db_column(:name).of_type(:string) }
  end

  describe 'associations' do
    it { should have_many(:stock_records) }
    it { should have_many(:books).through(:stock_records) }
  end

  describe 'public class methods' do
    context 'responds to its methods' do
      it 'should respond to :by_sold_publisher_books' do
        expect(shop.class).to respond_to(:by_sold_publisher_books)
      end
    end

    context 'executes methods correctly' do
      context 'self.by_sold_publisher_books' do

      end
    end
  end

  describe 'public instance methods' do
    context 'responds to its methods' do
      it { should respond_to(:publisher_books) }
    end
  end
end
