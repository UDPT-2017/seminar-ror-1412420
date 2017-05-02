require 'rails_helper'

RSpec.describe LinksController, type: :controller do
  login_user
  let!(:current_user) { subject.current_user }
  describe '.new' do
    before(:each) { get :new }
    it "should be true" do
      link = assigns(:link)
      expect(link.new_record?).to eq(true)
      expect(link.valid?).not_to eq(true)
    end
  end

  describe '.create' do
    before(:each) { get :new }
    it "should be true" do
      link = assigns(:link)
      expect(link.new_record?).to eq(true)
      expect(link.valid?).not_to eq(true)
    end
  end

  describe '.create' do
    context 'link has already existed' do
      let(:link) { create(:link, user: current_user) }
      it 'behave when link existed' do
        post :create, params: { link: { full_link: link.full_link}, format: :js }
        expect(assigns(:link)).to eq(link)
      end
    end

    context 'new link' do
      context 'save failed' do
        before(:each) { post :create, params: { link: { full_link: 'abc'}, format: :js }}
        it 'should be redirect' do
          expect(flash[:alert]).to eq('`abc` is not a url')
          expect(subject).to redirect_to root_path
        end
      end

      context 'save successfully' do
        before(:each) { post :create, params: { link: { full_link: 'https://www.youtube.com'}, format: :js }}
        it 'should be respond JS' do
          link = Link.last
          expect(assigns(:link)).to eq(link)
        end
      end
    end
  end
end
