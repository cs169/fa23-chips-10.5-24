# frozen_string_literal: true

class NewsItem < ApplicationRecord
  belongs_to :representative
  has_many :ratings, dependent: :delete_all
  attribute :ratings_sum, :integer, default: 0

  def self.find_for(representative_id)
    NewsItem.find_by(
      representative_id: representative_id
    )
  end

  # Return the average rating for this news item.
  # If there are no ratings, return nil.
  def rating
    return nil if ratings.size.zero?

    ratings_sum / ratings.size.to_f
  end
end
