module Api
  module V1
    class ApplicationController < Api::ApplicationController
      before_action :authenticate_user!

      rescue_from ActiveRecord::RecordNotFound do
        render_error(404, title: t('errors.not_found'))
      end

      rescue_from Apipie::ParamInvalid, Apipie::ParamMissing do |error|
        render_error(422, title: error.message.tr('"', "'"))
      end

      rescue_from ActionController::RoutingError do
        render_error(404, title: t('errors.not_found'))
      end

      private

      def render_model(status, serializer = self.class::SERIALIZER)
        json = serializer.new(@model).serialized_json
        render json: json, status: status
      end

      def render_error(status, error)
        title = error[:title]
        detail = error[:detail] || title
        errors = { title: title, detail: detail }

        render json: { errors: errors }, status: status
      end

      def handle_errors
        if result['result.policy.default']&.failure?
          render_error(403, title: t('errors.access_denied'))
        else
          render json: Api::V1::ErrorSerializer.new(@model).serialized_json, status: 422
        end
      end
    end
  end
end
