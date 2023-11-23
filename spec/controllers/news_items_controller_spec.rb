# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NewsItemsController, type: :controller do
  let!(:representative) { create(:representative) }
  let!(:news_items) { create_list(:news_item, 3, representative: representative) }
  let(:news_item) { news_items.first }

  describe 'GET #index' do
    it 'responds as successful' do
      get :index, params: { representative_id: representative.id }
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'responds as successful' do
      get :show, params: { representative_id: representative.id, id: news_item.id }
      expect(response).to be_successful
    end
  end
end
