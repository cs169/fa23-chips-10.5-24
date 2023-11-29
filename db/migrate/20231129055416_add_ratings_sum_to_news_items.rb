# frozen_string_literal: true

class AddRatingsSumToNewsItems < ActiveRecord::Migration[5.2]
  def change
    add_column :news_items, :ratings_sum, :integer
  end
end
