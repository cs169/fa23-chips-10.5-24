# frozen_string_literal: true

class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :news_item

  validates! :news_item, presence: true

  after_create :update_news_item_ratings_sum

  private

  def update_news_item_ratings_sum
    news_item.update(ratings_sum: news_item.ratings_sum + score)
    news_item.ratings << self
    news_item.save!
  end
end
