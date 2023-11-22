# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Event, type: :model do
  let(:state) { create(:state) }
  let(:county) { create(:county, state: state) }
  let(:valid_attributes) do
    {
      county:     county,
      start_time: DateTime.now.beginning_of_day.advance(days: 1),
      end_time:   DateTime.now.beginning_of_day.advance(days: 2)
    }
  end
  let(:event) { described_class.new(valid_attributes) }

  describe '#county_names_by_id' do
    it 'returns the county names and ids' do
      expect(event.county_names_by_id).to eq({ county.name => county.id })
    end
  end
end
