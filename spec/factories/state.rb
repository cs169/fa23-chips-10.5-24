# frozen_string_literal: true

FactoryBot.define do
  factory :state do
    name { 'California' }
    symbol { 'CA' }
    fips_code { 0o6 }
    is_territory { 0 }
    lat_min { 0.0 }
    lat_max { 0.0 }
    long_min { 0.0 }
    long_max { 0.0 }
  end
end
