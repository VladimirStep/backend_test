require 'rails_helper'

RSpec.describe StockRecord, type: :model do
  it 'has valid factory' do
    expect(build(:stock_record)).to be_valid
  end

  let(:stock_record) { build(:stock_record) }
  subject { stock_record }

  describe 'database' do
    it { should have_db_column(:in_stock).of_type(:integer) }
    it { should have_db_column(:sold).of_type(:integer) }
  end

  describe 'associations' do
    it { should belong_to(:book) }
    it { should belong_to(:shop) }
  end

  describe 'public instance methods' do
    context 'responds to its methods' do
      it { should respond_to(:sell_book) }
    end
  end
end
