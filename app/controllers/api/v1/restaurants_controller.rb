module Api
  module V1
    class RestaurantsController < BaseController
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

      def empty_response
        render json: { none: 'Sorry, but no restaurants match your criteria' }, status: 404
      end
    end
  end
end
