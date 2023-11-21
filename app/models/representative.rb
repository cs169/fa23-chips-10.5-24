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
      address_line1 = official.address ? official.address[0].line1 : nil
      address_line2 = official.address ? official.address[0].line2 : nil
      address_city = official.address ? official.address[0].city : nil
      address_state = official.address ? official.address[0].state : nil
      address_zip = official.address ? official.address[0].zip : nil

      rep = Representative.create!({ name: official.name, ocdid: ocdid_temp,
        title: title_temp, 
        address_line1: address_line1, address_line2: address_line2, 
        address_city: address_city, address_state: address_state,
        address_zip: address_zip, party: official.party, photo_url: official.photo_url})
      reps.push(rep)
    end

    reps
  end
end
