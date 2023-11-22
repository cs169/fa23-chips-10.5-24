# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserController, type: :controller do
  let(:user) { create(:user) }

  describe 'GET #profile' do
    describe 'the user is logged in' do
      before do
        session[:current_user_id] = user.id
        get :profile
      end

      it 'assigns @user' do
        expect(assigns(:user)).to eq(user)
      end
    end
  end
end
