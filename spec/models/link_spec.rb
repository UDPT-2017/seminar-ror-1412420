require 'rails_helper'

RSpec.describe Link, type: :model do
  describe '.factory' do
    subject { build(:link)  }
    it { should be_valid }
  end

  describe 'validate' do
    describe '.full_link' do
      context 'full_link is empty' do
        let(:link) { build(:link, full_link: '') }
        it { expect(link.valid?).not_to eq(true) }
      end
      context 'full_link is present' do
        let(:link) { build(:link) }
        it { expect(link.valid?).to eq(true) }
      end

      context 'full_link is not a url' do
        let(:link) { build(:link, full_link: 'something just like this') }
        it { expect(link.valid?).not_to eq(true) }
      end

      context 'full_link is a url' do
        let(:link) { build(:link, full_link: 'https://www.youtube.com') }
        it { expect(link.valid?).to eq(true) }
      end
    end

    describe '.short_link' do
      context 'short_link is empty' do
        let(:link) { build(:link, short_link: '') }
        it { expect(link.valid?).not_to eq(true) }
      end
      context 'short_link is present' do
        let(:link) { build(:link) }
        it { expect(link.valid?).to eq(true) }
      end

      context 'short_link is not a uniquess link(short?)' do
        let!(:link) { create(:link, short_link: '123') }
        let!(:link1) { build(:link, short_link: '123') }
        it { expect(link1.valid?).not_to eq(true) }
      end

      context 'short_link is uniquess link(short?)' do
        let!(:link) { create(:link, short_link: '123') }
        let!(:link1) { build(:link, short_link: '1234') }
        it { expect(link1.valid?).to eq(true) }
      end
    end
  end

  describe 'association' do
    it { should belong_to(:user) }
    it { should have_many(:hits) }
  end
end
