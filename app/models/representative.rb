# frozen_string_literal: true

class Representative < ApplicationRecord
  has_many :news_items, dependent: :delete_all

  def self.civic_api_to_representative_params(rep_info)
    reps = []

    rep_info.officials.each_with_index do |official, index|
      ocdid_temp = ''
      title_temp = ''

      rep_info.offices.each do |office|
        if office.official_indices.include? index
          title_temp = office.name
          ocdid_temp = office.division_id
        end
      end
      reps.push(create_representative(official, title_temp, ocdid_temp))
    end

    reps
  end

  def self.create_representative(official, title, ocdid)
    address = official.address ? official.address[0] : nil
    address_line1, address_line2, address_city, address_state, address_zip = extract_address(address)
    Representative.where(name: official.name, ocdid: ocdid, title: title,
                         address_line1: address_line1, address_line2: address_line2,
                         address_city: address_city, address_state: address_state,
                         address_zip: address_zip, party: official.party,
                         photo_url: official.photo_url).first_or_create
  end

  def self.extract_address(address)
    if address
      [address.line1, address.line2, address.city, address.state, address.zip]
    else
      [nil, nil, nil, nil, nil]
    end
  end
end
