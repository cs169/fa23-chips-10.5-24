# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NewsItemsController, type: :controller do
  let!(:representative) { create(:representative) }
  let!(:news_items) { create_list(:news_item, 3, representative: representative) }
  let(:news_item) { news_items.first }

  describe 'GET #index' do
    describe 'the representative exists' do
      before { get :index, params: { representative_id: representative.id } }

      it 'responds as successful' do
        expect(response).to be_successful
      end

      it 'assigns @news_items' do
        expect(assigns(:news_items)).to match_array(news_items)
      end
    end

    describe 'the representative does not exist' do
      it 'raises a RecordNotFound error' do
        index_result = proc { get :index, params: { representative_id: 'none' } }
        expect(index_result).to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe 'GET #show' do
    describe 'the news item exists' do
      before { get :show, params: { representative_id: representative.id, id: news_item.id } }

      it 'responds as successful' do
        expect(response).to be_successful
      end

      it 'assigns @news_item' do
        expect(assigns(:news_item)).to eq(news_item)
      end
    end

    describe 'the news item does not exist' do
      it 'raises a RecordNotFound error' do
        show_result = proc { get :show, params: { representative_id: representative.id, id: 'none' } }
        expect(show_result).to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
