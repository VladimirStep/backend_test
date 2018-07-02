require 'rails_helper'

RSpec.describe Publisher, type: :model do
  it 'has valid factory' do
    expect(build(:publisher)).to be_valid
  end

  let(:publisher) { build(:publisher) }
  subject { publisher }

  describe 'database' do
    it { should have_db_column(:name).of_type(:string) }
  end

  describe 'associations' do
    it { should have_many(:books) }
  end
end
