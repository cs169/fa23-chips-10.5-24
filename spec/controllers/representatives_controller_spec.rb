# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RepresentativesController, type: :controller do
  let(:representative) { create(:representative) } # assuming you have a factory for representative

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

  describe 'GET #index' do
    let!(:representatives) { create_list(:representative, 3) } # creates 3 representatives

    before do
      get :index
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'assigns @representatives' do
      expect(assigns(:representatives)).to match_array(representatives)
    end
  end
end
