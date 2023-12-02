# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LoginController, type: :controller do
  describe 'GET #login' do
    it 'renders the login template' do
      get :login
      expect(response).to render_template(:login)
    end
  end

  describe 'GET #logout' do
    it 'logs the user out and redirects to the home page' do
      session[:current_user_id] = 114_514 # Simulate a logged in user
      get :logout
      expect(session[:current_user_id]).to be_nil
      expect(response).to redirect_to(root_path)
    end
  end

  describe 'GET #github' do
    let(:user) { create(:user) } # Create a user using FactoryBot

    before do
      allow(controller).to receive(:create_session).with(:create_github_user)
      get :github, format: :json
    end

    it 'calls the create_session method with :create_github_user' do
      expect(controller).to have_received(:create_session).with(:create_github_user)
    end
  end

  describe 'GET #google_oauth2' do
    let(:user) { create(:user) } # Create a user using FactoryBot

    before do
      allow(controller).to receive(:create_session).with(:create_google_user)
      get :google_oauth2, format: :json
    end

    it 'calls the create_session method with :create_google_user' do
      expect(controller).to have_received(:create_session).with(:create_google_user)
    end
  end

  describe '#create_session' do
    let(:user) { create(:user) } # Create a user using FactoryBot
    let(:create_if_not_exists) { true }

    before do
      allow(controller).to receive(:params).and_return({ user_id: user.id })
      allow(controller).to receive(:find_or_create_user).and_return(user)
      allow(controller).to receive(:root_url).and_return(root_path)
      allow(controller).to receive(:redirect_to).with(root_path)
      controller.send(:create_session, create_if_not_exists)
    end

    it 'sets the session user_id to the given user id' do
      expect(session[:current_user_id]).to eq(user.id)
    end
  end

  def create_if_not_exists(_user_info)
    user
  end

  describe '#find_or_create_user' do
    let(:user) { create(:user, provider: 'github', uid: '12345') } # Create a user using FactoryBot
    let(:user_info) { { 'provider' => 'github', 'uid' => '12345', 'info' => { 'name' => nil } } }

    before do
      allow(controller).to receive(:params).and_return({ user_id: user.id })
    end

    it 'finds an existing user' do
      expect(controller.send(:find_or_create_user, user_info, :create_github_user)).to eq(user)
    end

    it 'creates a new user if one does not exist' do
      user_info['uid'] = '12346' # Change the uid so a new user will be created
      expect { controller.send(:find_or_create_user, user_info, :create_github_user) }.to change(User, :count).by(1)
    end
  end

  describe '#create_google_user' do
    let(:user) { create(:user, provider: 'google_oauth2', uid: '12345') } # Create a user using FactoryBot
    let(:user_info_google) do
      { 'provider' => 'google_oauth2', 'uid' => '12345',
     'info' => { 'first_name' => 'John', 'last_name' => 'Doe', 'email' => '' } }
    end

    before do
      allow(controller).to receive(:params).and_return({ user_id: user.id })
    end

    it 'creates a new user' do
      user_info_google['uid'] = '12346' # Change the uid so a new user will be created
      expect do
        controller.send(:find_or_create_user, user_info_google, :create_google_user)
      end.to change(User, :count).by(1)
    end
  end

  describe '#already_logged_in' do
    let(:user_profile_path) { '/user/profile' }
    let(:notice_message) { 'You are already logged in. Logout to switch accounts.' }

    context 'when a user is already logged in' do
      before do
        session[:current_user_id] = 1
        allow(controller).to receive(:redirect_to).with(user_profile_path, { notice: notice_message })
        controller.send(:already_logged_in)
      end

      it 'redirects to the user profile page' do
        expect(controller).to have_received(:redirect_to).with(user_profile_path, { notice: notice_message })
      end
    end

    context 'when no user is logged in' do
      before do
        session[:current_user_id] = nil
        allow(controller).to receive(:redirect_to)
        controller.send(:already_logged_in)
      end

      it 'does not redirect' do
        expect(controller).not_to have_received(:redirect_to)
      end
    end
  end
end
