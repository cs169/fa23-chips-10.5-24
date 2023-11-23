# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MapController, type: :controller do
  # Assuming you have factories for State and County
  let!(:state) { create(:state, symbol: 'CA') }
  let!(:county) { create(:county, state: state, fips_code: '12345') }

  describe 'GET #index' do
    it 'responds as successful' do
      get :index
      expect(response).to be_successful
    end
  end

  describe 'GET #state' do
    describe 'state exists' do
      it 'responds as successful' do
        get :state, params: { state_symbol: 'CA' }
        expect(response).to be_successful
      end
    end
  end

  describe 'GET #county' do
    describe 'state and county exist' do
      it 'redirects to search representatives path' do
        get :county, params: { state_symbol: 'CA', std_fips_code: '12345' }
        expect(response).to redirect_to(search_representatives_path(address: county.name))
      end
    end

    describe 'state does not exist' do
      it 'redirects to root' do
        get :county, params: { state_symbol: 'XX', std_fips_code: '12345' }
        expect(response).to redirect_to(root_path)
      end
    end

    describe 'county does not exist' do
      it 'redirects to root' do
        get :county, params: { state_symbol: 'CA', std_fips_code: '99999' }
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
