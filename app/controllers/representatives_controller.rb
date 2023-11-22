# frozen_string_literal: true

class RepresentativesController < ApplicationController
  def show
    id = params[:id]
    @representative = Representative.find(id)
  end
end
