# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Rating, type: :model do
  it 'belongs to a user' do
    rating = described_class.new
    user = User.new
    user.ratings << rating
  end

  it 'belongs to a news item' do
    rating = described_class.new
    news_item = NewsItem.new
    news_item.ratings << rating
  end
end
