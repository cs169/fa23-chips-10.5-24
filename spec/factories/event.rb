# frozen_string_literal: true

FactoryBot.define do
  factory :event do
    name { 'Fun Event' }
    description { 'Something Fun' }
    county
    start_time { DateTime.now.beginning_of_day.advance(days: 1) }
    end_time { DateTime.now.beginning_of_day.advance(days: 2) }
  end
end
