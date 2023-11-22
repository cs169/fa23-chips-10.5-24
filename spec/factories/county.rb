# frozen_string_literal: true

FactoryBot.define do
  factory :county do
    name { 'Alameda' }
    state
    fips_code { 0o1 }
    fips_class { '00' }
  end
end
