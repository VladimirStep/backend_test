require 'rails_helper'

RSpec.describe Book, type: :model do
  it 'has valid factory' do
    expect(build(:book)).to be_valid
  end

  let(:book) { build(:book) }
  subject { book }

  describe 'database' do
    it { should have_db_column(:title).of_type(:string) }
  end

  describe 'associations' do
    it { should belong_to(:publisher) }
    it { should have_many(:stock_records) }
    it { should have_many(:shops).through(:stock_records) }
  end

  describe 'public instance methods' do
    context 'responds to its methods' do
      it { should respond_to(:copies_in_stock) }
    end
  end
end
