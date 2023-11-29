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

  describe '#rating' do
    let(:user) { create(:user) }
    let(:representative) { create(:representative) }
    let(:news_item) { create(:news_item, representative: representative) }
    let(:rating1) { Rating.create!(score: 1, news_item: news_item, user: user) }
    let(:rating2) { Rating.create!(score: 2, news_item: news_item, user: user) }

    it 'returns the average rating for the news item' do
      expect(rating1).not_to be_nil # Only to make sure the rating is created.
      expect(rating2).not_to be_nil
      expect(described_class.find(news_item.id).rating).to be_within(0.001).of(1.5)
    end

    it 'returns nil if there are no ratings' do
      expect(described_class.find(news_item.id).rating).to be_nil
    end

    it 'updates the rating when a rating is updated' do
      expect(rating1).not_to be_nil # Only to make sure the rating is created.
      expect(rating2).not_to be_nil
      rating1.update_rating(3)
      expect(described_class.find(news_item.id).rating).to be_within(0.001).of(2.5)
    end
  end
end
