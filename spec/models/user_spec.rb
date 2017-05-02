require 'rails_helper'

RSpec.describe User, type: :model do
  describe '.factory' do
    subject { build(:user)  }
    it { should be_valid }
  end

  describe 'validates' do
    describe '.name' do
      context 'name is empty' do
        let(:user) { build(:user, name: '') }
        it { expect(user.valid?).not_to eq(true) }
      end
      context 'name is present' do
        let(:user) { build(:user, name: 'Austin') }
        it { expect(user.valid?).to eq(true) }
      end
    end

    describe '.email' do
      context 'email is empty' do
        let(:user) { build(:user, email: '') }
        it { expect(user.valid?).not_to eq(true) }
      end
      context 'email is present' do
        let(:user) { build(:user, email: 'phanphuocdt@gmail.com') }
        it { expect(user.valid?).to eq(true) }
      end
    end

    describe '.password' do
      context 'password is empty' do
        let(:user) { build(:user, password: '') }
        it { expect(user.valid?).not_to eq(true) }
      end
      context 'password is present' do
        let(:user) { build(:user, password: '12345678') }
        it { expect(user.valid?).to eq(true) }
      end
      context 'password less than 8 chars' do
        let(:user) { build(:user, password: '12345') }
        it { expect(user.valid?).not_to eq(true) }
      end
      context 'password longer or equal than 8 chars' do
        let(:user) { build(:user, password: '1234545678') }
        it { expect(user.valid?).to eq(true) }
      end
    end

    describe 'email uniquess' do
      let!(:user) { create(:user, email: 'p@p.com') }
      context 'email is duplicated' do
        let(:u1) { build(:user, email: 'p@p.com') }
        it { expect(u1.valid?).not_to eq(true) }
      end
      context 'email is different' do
        let(:u2) { build(:user) }
        it { expect(u2.valid?).to eq(true) }
      end
    end
  end

  describe 'counter cache' do
    let(:user) { create(:user_with_links, links_count: 5) }
    it { expect(user.links_count).to eq(5) }
  end

  describe 'association' do
    it { should have_many(:links) }
  end
end
