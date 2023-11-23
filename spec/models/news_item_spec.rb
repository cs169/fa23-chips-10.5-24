# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NewsItem, type: :model do
  describe '.find_for' do
    it 'returns the news item for the specified representative' do
      representative = create(:representative)
      news_item = create(:news_item, representative: representative)
      expect(described_class.find_for(representative.id)).to eq(news_item)
    end
  end
end
