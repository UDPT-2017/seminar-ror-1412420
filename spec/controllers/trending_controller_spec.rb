require 'rails_helper'

RSpec.describe TrendingController, type: :controller do
  login_user
  let!(:current_user) { subject.current_user }

  describe '.index' do
    context 'has at least a link' do
      let!(:link) { create(:link, user: current_user) }
      let!(:link1) { create(:link, user: current_user) }
      it 'should be true' do
        get :index
        links_c = assigns(:links)
        link_c = assigns(:link)
        expect(links_c).to match_array([link, link1])
        expect(link_c).to eq(link1)
      end
    end

    context 'empty links' do
      it 'should be true' do
        get :index
        expect(subject).to render_template("shared/empty")
      end
    end
  end

  describe '.show' do
    let(:link) { create(:link, user: current_user) }
    it 'should be true' do
      get :show, params: { id: link.id }
      expect(subject).to render_template(:index)
    end
  end
end
