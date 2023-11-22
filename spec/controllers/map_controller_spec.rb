# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MapController, type: :controller do
  # Assuming you have factories for State and County
  let!(:state) { create(:state, symbol: 'CA') }
  let!(:county) { create(:county, state: state, fips_code: '12345') }

  describe 'GET #index' do
    before do
      get :index
    end

    it 'responds as successful' do
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
    context 'when state and county exist' do
      it 'redirects to search representatives path' do
        get :county, params: { state_symbol: 'CA', std_fips_code: '12345' }
        expect(response).to redirect_to(search_representatives_path(address: county.name))
      end
    end

    context 'when state does not exist' do
      it 'redirects to root with an error message' do
        get :county, params: { state_symbol: 'XX', std_fips_code: '12345' }
        expect(response).to redirect_to(root_path)
      end
    end

    context 'when county does not exist' do
      it 'redirects to root with an error message' do
        get :county, params: { state_symbol: 'CA', std_fips_code: '99999' }
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
