# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MyNewsItemsController, type: :controller do
  let!(:representative) { create(:representative, name: 'Joe Biden') }
  let(:user) { create(:user) }

  describe 'GET #search' do
    before do
      session[:current_user_id] = user.id
    end

    it 'gives me some news about Joe Biden' do
      get :search, params: { representative_id: representative.id, issue: 'Unemployment' }
      expect(response).to be_successful
    end
  end
end
