# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationMailer, type: :mailer do
  describe 'default from address' do
    it 'is set to the correct address' do
      expect(described_class.default[:from]).to eq('from@example.com')
    end
  end
end
