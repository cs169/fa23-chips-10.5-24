# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    provider { 1 }
    uid { '123' }
    email { 'johndoe@gmail.com' }
    first_name { 'John' }
    last_name { 'Doe' }
  end
end
