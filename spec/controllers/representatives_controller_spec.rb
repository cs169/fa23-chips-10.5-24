# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RepresentativesController, type: :controller do
  let(:representative) { create(:representative) }

  describe 'GET #show' do
    before do
      get :show, params: { id: representative.id }
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'assigns @representative' do
      expect(assigns(:representative)).to eq(representative)
    end
  end
end
