module Api
  module V1
    class ProjectSerializer < Api::V1::BaseSerializer
      has_many :tasks, serializer: Api::V1::Tasks::MainSerializer
      belongs_to :user
      attributes :name

      link :self, :url
    end
  end
end
