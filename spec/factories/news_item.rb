# frozen_string_literal: true

FactoryBot.define do
  factory :news_item do
    title { 'Some News' }
    link { 'somelink.com' }
    description { 'Some new news' }
    representative
  end
end
