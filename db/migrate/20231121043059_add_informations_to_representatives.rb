# frozen_string_literal: true

class AddInformationsToRepresentatives < ActiveRecord::Migration[5.2]
  def change
    add_column :representatives, :address_line1, :string
    add_column :representatives, :address_line2, :string
    add_column :representatives, :address_city, :string
    add_column :representatives, :address_state, :string
    add_column :representatives, :address_zip, :string
    add_column :representatives, :party, :string
    add_column :representatives, :photo_url, :string
  end
end
