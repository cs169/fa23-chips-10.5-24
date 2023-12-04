# frozen_string_literal: true

require 'rails_helper'
require 'ostruct'

RSpec.describe MyNewsItemsController, type: :controller do
  let!(:representative) { create(:representative, name: 'Joe Biden') }
  let(:user) { create(:user) }

  before do
    session[:current_user_id] = user.id
  end

  describe 'GET #search' do
    let(:news) { instance_double(News) }

    before do
      allow(News).to receive(:new).and_return(news)
    end

    it 'gives me some news about Joe Biden' do
      allow(news).to receive(:get_everything).and_return([OpenStruct.new({ title: 'Joe Biden', url: '2',
description: '1' })])
      get :search, params: { representative_id: representative.id, issue: 'Unemployment' }
      expect(response).to be_successful
    end

    it 'gives no news about Joe Biden' do
      allow(news).to receive(:get_everything).and_return([])
      get :search, params: { representative_id: representative.id, issue: 'Homelessness' }
      expect(response).to be_successful
    end
  end

  describe 'POST #create_rating' do
    let(:news_item) { create(:news_item) }

    context 'when the user has not already rated the news item' do
      it 'creates a new rating and returns a success message' do
        post :create_rating, params: { representative_id: representative.id, id: news_item.id, rating: 5 }

        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)['message']).to eq('Rating created')
        expect(Rating.where(user: user, news_item: news_item).count).to eq(1)
      end
    end

    context 'when the user has already rated the news item' do
      before do
        Rating.create!(user: user, news_item: news_item, score: 5)
      end

      it 'does not create a new rating and returns an error message' do
        post :create_rating, params: { representative_id: representative.id, id: news_item.id, rating: 5 }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['error']).to eq('You have already rated this news item')
        expect(Rating.where(user: user, news_item: news_item).count).to eq(1)
      end
    end
  end
end
