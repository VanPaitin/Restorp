class Api::V1::CitiesController < ApplicationController
  def index
    render json: City.search_by(params[:query])
  end
end
