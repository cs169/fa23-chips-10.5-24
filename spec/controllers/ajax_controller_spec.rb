# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AjaxController, type: :controller do
  let(:state) { create(:state, symbol: 'CA') }
  let!(:counties) { create_list(:county, 3, state: state) }

  describe 'GET #counties' do
    it 'responds as successful' do
      get :counties, params: { state_symbol: 'CA' }, format: :json
      expect(response).to be_successful
    end
  end
end
