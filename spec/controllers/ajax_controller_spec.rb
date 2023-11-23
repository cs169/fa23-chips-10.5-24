# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AjaxController, type: :controller do
  describe 'GET #counties' do
    it 'responds as successful' do
      state = create(:state, symbol: 'CA')
      create_list(:county, 3, state: state)
      get :counties, params: { state_symbol: 'CA' }, format: :json
      expect(response).to be_successful
    end
  end
end
