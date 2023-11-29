# frozen_string_literal: true

class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :news_item

  validates! :news_item, presence: true

  after_create :update_news_item_ratings_sum

  # Update the rating for this news item.
  # You should call this method instead of updating the score directly.
  def update_rating(new_rating)
    delta = new_rating - score
    update!(score: new_rating)
    news_item.update!(ratings_sum: news_item.ratings_sum + delta)
  end

  private

  def update_news_item_ratings_sum
    news_item.update!(ratings_sum: news_item.ratings_sum + score)
  end
end
