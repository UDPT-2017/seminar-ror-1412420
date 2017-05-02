require 'rails_helper'

RSpec.describe RevertController, type: :controller do
  login_user
  let!(:current_user) { subject.current_user }

  describe '.new' do
    it "should be true" do
      get :index
      link = assigns(:link)
      expect(link.new_record?).to eq(true)
      expect(link.valid?).not_to eq(true)
    end
  end

  describe '.create' do
    context 'not a link' do
      it 'should be true' do
        post :create, params: { link: { short_link: 'abc' }, format: :js }
        expect(flash[:alert]).to eq('`abc` is not a link')
        expect(subject).to redirect_to revert_index_path
      end
    end

    context 'is a link' do
      it 'not a short link' do
        post :create, params: { link: { short_link: 'https://www.google.com.vn' }, format: :js }
        expect(flash[:alert]).to eq('`https://www.google.com.vn` is not a short link')
        expect(subject).to redirect_to revert_index_path
      end

      context 'a short link - not save' do
        it 'should be true' do
          post :create, params: { link: { short_link: 'http://bit.ly/2kHlHaE' }, format: :js }
          link = assigns(:link)
          expect(link.full_link).to eq('https://www.youtube.com/')
        end
      end

    end
  end
end
