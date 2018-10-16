class Api::V1::RestaurantsController < ApplicationController
  def index
    restaurants = if params[:city_id].present?
      Restaurant.by_city(params[:city_id])
    else
      Restaurant.all
    end

    if params[:query]
      restaurants = restaurants.search_by(params[:query])
    end

    if params[:cuisine_ids]
      restaurants = restaurants.by_cuisines(params[:cuisine_ids])
    end

    return empty_response if restaurants.empty?

    paginated_restaurants = restaurants.includes(:cuisines, :meals).page(params[:page]).per(params[:per_page])

    render json: data(paginated_restaurants), status: 200
  end

  private

  def data(restaurants)
    {
      meta: {
        total_restaurants_matched: restaurants.total_count,
        restaurants_returned: restaurants.size,
        current_page: restaurants.current_page,
        total_pages: restaurants.total_pages
      },
      data: ActiveModel::Serializer::CollectionSerializer.new(restaurants)
    }
  end

  def empty_response
    render json: { none: 'Sorry, but no restaurants match your criteria' }, status: 404
  end
end
