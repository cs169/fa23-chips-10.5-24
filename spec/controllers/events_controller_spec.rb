# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  let!(:state) { create(:state, symbol: 'CA') }
  let!(:county) { create(:county, state: state, fips_code: '12345') }
  let!(:events) { create_list(:event, 3, county: county) }

  describe 'GET #index' do
    it 'assigns @events' do
      get :index
      expect(assigns(:events)).to match_array(Event.all)
    end

    it 'assigns @events filtered by state' do
      get :index, params: { 'filter-by': 'state-only', state: 'CA' }
      expect(assigns(:events)).to match_array(events)
    end

    it 'assigns @events filtered by county' do
      get :index, params: { 'filter-by': 'state-county', state: 'CA', county: '12345' }
      expect(assigns(:events)).to match_array(events)
    end
  end

  describe 'GET #show' do
    describe 'the event exists' do
      let(:event) { events.first }

      it 'responds as successful' do
        get :show, params: { id: event.id }
        expect(response).to be_successful
      end
    end
  end
end
