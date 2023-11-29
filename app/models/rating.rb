# frozen_string_literal: true

class Rating < ActiveRecord
  belongs_to :user
  belongs_to :news_item
end
