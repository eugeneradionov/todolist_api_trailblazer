module Api
  module V1
    class Step::ParseParams
      include Uber::Callable

      def call(options, params:, params_fetch:, params_permit:, **)
        params_merge = options[:params_merge] || {}

        options[:params] = params.fetch(params_fetch)
                                 .fetch(:data)
                                 .fetch(:attributes)
                                 .permit(params_permit)
                                 .merge(params_merge)
      end
    end
  end
end
