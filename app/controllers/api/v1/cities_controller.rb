class Api::V1::CitiesController < ApplicationController
  def index
    cities = City.search_by(params[:query])

    if cities.empty?
      render json: { none: "No cities match your query term" }, status: 404
    else
      render json: cities, status: 200
    end
  end
end
