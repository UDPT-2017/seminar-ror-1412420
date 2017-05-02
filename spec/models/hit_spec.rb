require 'rails_helper'

RSpec.describe Hit, type: :model do
  describe '.factory' do
    subject { build(:hit)  }
    it { should be_valid }
  end

  describe 'associations' do
    it { should belong_to(:link) }
  end

  describe '#group_by_date_within_days' do
    let!(:link) { create(:link_with_list_hits) }
    it 'should be true' do
      ex = Hit.where("date(created_at) >= date(?)", 30.days.ago).group("date(created_at)").count
      expect(Hit.group_by_date_within_days(30)).to eq(ex)
    end
  end

  describe '#group_by_date_within_days' do
    let!(:link) { create(:link_with_list_hits) }
    it 'should be true' do
      ex = Hit.where("date(created_at) >= date(?)", 30.days.ago).group("date(created_at)").count
      expect(Hit.group_by_date_within_days(30)).to eq(ex)
    end
  end

  describe '#group_by_location' do
    let!(:link) { create(:link_with_list_hits) }
    it 'should be true' do
      ex = Hit.group(:location).count
      expect(Hit.group_by_location).to eq(ex)
    end
  end

  describe '#group_by_ip' do
    let!(:link) { create(:link_with_list_hits) }
    it 'should be true' do
      ex = Hit.group(:ip_address).count
      expect(Hit.group_by_ip).to eq(ex)
    end
  end

  describe '.ip_address' do
    let!(:hit) { create(:hit, ip_address: '12.12.12.12') }
    it { expect(hit.send(:address)).to eq('12.12.12.12') }
  end
end
