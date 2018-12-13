module Api
  module V1
    class Tasks::PositionSerializer < Api::V1::BaseSerializer
      set_type :task

      attributes :position
    end
  end
end
