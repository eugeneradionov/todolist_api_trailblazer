module Api
  module V1
    class Tasks::MainSerializer < Api::V1::BaseSerializer
      set_type :task

      has_many :comments

      attributes :name, :position, :comments_count

      attribute :due_date, &:deadline
      attribute :done, &:completed
    end
  end
end
