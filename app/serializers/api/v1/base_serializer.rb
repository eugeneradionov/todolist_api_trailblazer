module Api
  module V1
    class BaseSerializer
      include FastJsonapi::ObjectSerializer

      set_key_transform :camel_lower
    end
  end
end
