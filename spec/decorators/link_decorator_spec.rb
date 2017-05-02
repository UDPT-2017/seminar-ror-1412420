require 'rails_helper'

describe LinkDecorator do
  let(:link) { create(:link) }
  describe '.short_url', skip: true do
    it { expect(link).to eq("#{request.base_url}/#{link.short_link}") }
  end

  describe '.short_decorator_url', skip: true do
    it { expect(link).to eq("#{request.host}/#{link.short_link}") }
  end

  describe '.full' do
    it { expect(link.decorate.full).to eq(truncate(link.full_link, length: 50)) }
  end

  describe '.created' do
    it { expect(link.decorate.created).to eq(link.created_at.strftime("%b, %d")) }
  end
end
