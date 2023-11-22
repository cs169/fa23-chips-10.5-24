# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'return correct instance methods' do
    let(:user) { FactoryBot.create(:user, first_name: 'John', last_name: 'Doe', provider: 1) }

    describe '#name' do
      it 'returns the full name of the user' do
        expect(user.name).to eq('John Doe')
      end
    end

    describe '#auth_provider' do
      it 'returns the readable name of the provider' do
        expect(user.auth_provider).to eq('Google')
      end
    end
  end

  describe 'find user according to provider' do
    let!(:google_user) { create(:user, provider: 1, uid: '123') }
    let!(:github_user) { create(:user, provider: 2, uid: '456') }

    describe '.find_google_user' do
      it 'finds the user with Google OAuth2 provider' do
        expect(User.find_google_user('123')).to eq(google_user)
      end
    end

    describe '.find_github_user' do
      it 'finds the user with GitHub provider' do
        expect(User.find_github_user('456')).to eq(github_user)
      end
    end
  end
end
