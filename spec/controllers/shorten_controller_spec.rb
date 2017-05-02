require 'rails_helper'

RSpec.describe ShortenController, type: :controller do
  login_user
  let!(:current_user) { subject.current_user }

  describe '.index' do
    let(:link) { create(:link) }
    context 'short link not exist' do
      it 'should be true' do
        get :index, params: { id: "#{link.short_link}T" }
        expect(subject).to redirect_to(root_path)
      end
    end

    context 'short exist' do
      it 'should be true' do
        get :index, params: { id: link.short_link }
        expect(subject).to redirect_to link.full_link
      end
    end
  end
end
