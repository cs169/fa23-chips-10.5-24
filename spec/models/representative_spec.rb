# frozen_string_literal: true

require 'rails_helper'
require 'google/apis/civicinfo_v2'

describe Representative do
  context 'when search twice with the same parameter' do
    let(:address) do
      instance_double(Google::Apis::CivicinfoV2::SimpleAddressType, line1: 'Address Line 1', line2: 'Address Line 2',
     city: 'A City', state: 'A State', zip: '11451')
    end
    let(:official) do
      instance_double(Google::Apis::CivicinfoV2::Official, name: 'Name', party: 'Some Party', address: [address],
     photo_url: nil)
    end
    let(:office) do
      instance_double(Google::Apis::CivicinfoV2::Office, official_indices: [0], name: 'Oakland DMV',
division_id: 'division_id')
    end
    let(:rep_info) do
      instance_double(Google::Apis::CivicinfoV2::RepresentativeInfoResponse, officials: [official], offices: [office])
    end

    it 'only create one instance' do
      2.times { described_class.civic_api_to_representative_params(rep_info) }
      expect(described_class.where(name: 'Name', ocdid: 'division_id', title: 'Oakland DMV').count).to eq(1)
    end
  end
end
