class Api::V1::MealsController < ApplicationController
  def index
    unless params[:city_id] && params[:query]
      return render(
        json: { "invalid" => "You need to provide a city id and a query term" },
        status: 422
      )
    end

    city = City.find_by(id: params[:city_id])

    return empty_response unless city

    meals = city.meals.includes(:cuisine).search_by(params[:query])

    return empty_response if meals.empty?

    paginated_meals = meals.page(params[:page]).per(params[:per_page])

    render json: data(paginated_meals), status: 200
  end

  private

  def empty_response
    render json: { none: 'No meals with that query term are in the given city' }, status: 404
  end

  def data(meals)
    {
      meta: {
          total_meals_matched: meals.total_count,
          meals_returned: meals.size,
          current_page: meals.current_page,
          total_pages: meals.total_pages
      },
      data: ActiveModel::Serializer::CollectionSerializer.new(meals)
    }
  end
end
