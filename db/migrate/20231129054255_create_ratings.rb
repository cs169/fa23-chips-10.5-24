# frozen_string_literal: true

class CreateRatings < ActiveRecord::Migration[5.2]
  def change
    create_table :ratings do |t|
      t.timestamps null: false
      t.integer :score
      t.references :user, foreign_key: true
      t.references :news_item, foreign_key: true
    end
  end
end
