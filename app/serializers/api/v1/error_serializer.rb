module Api
  module V1
    class ErrorSerializer
      def initialize(model)
        @model = model
      end

      def serialized_json
        errors = @model.errors.messages.map do |field, errors|
          errors.map do |error_message|
            {
              title: error_message,
              detail: "#{field.to_s.capitalize} #{error_message}",
              source: { pointer: "/data/attributes/#{field}" },
              status: 422
            }
          end
        end

        { errors: errors.flatten }
      end
    end
  end
end
