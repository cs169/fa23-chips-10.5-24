# frozen_string_literal: true

FactoryBot.define do
  factory :representative do
    name { 'John Doe' }
    title { 'Mayor' }
    party { 'Democrat' }
    address_line1 { '123 Main St' }
    address_line2 { 'Apt 1' }
    address_city { 'Oakland' }
    address_state { 'CA' }
    address_zip { '94612' }
    photo_url { 'https://www.google.com/images/branding/googlelogo/1x/googlelogo_color_272x92dp.png' }
  end
end
