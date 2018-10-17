module Api
  module V1
    class BaseController < ApplicationController

      private

      def data(collection)
        {
          meta: {
            total_records_matched: collection.total_count,
            records_returned: collection.size,
            current_page: collection.current_page,
            total_pages: collection.total_pages
          },
          data: ActiveModel::Serializer::CollectionSerializer.new(collection)
        }
      end
    end
  end
end

