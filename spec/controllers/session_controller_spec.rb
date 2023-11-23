# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SessionController, type: :controller do
  controller do
    def auth_action
      render plain: 'OK'
    end
  end

  let(:user) { create(:user) }

  before do
    routes.draw { get 'auth_action' => 'session#auth_action' }
  end

  describe 'GET #auth_action' do
    describe 'user is logged in' do
      before do
        session[:current_user_id] = user.id
        get :auth_action
      end

      it 'assigns @current_user' do
        expect(assigns(:current_user)).to eq(user)
      end
    end

    describe 'no user is logged in' do
      before do
        get :auth_action
      end

      it 'redirects to the login page' do
        expect(response).to redirect_to(login_url)
      end
    end
  end
end
