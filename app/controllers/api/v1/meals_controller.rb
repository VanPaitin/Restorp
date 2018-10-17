module Api
  module V1
    class MealsController < BaseController
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
    end
  end
end
