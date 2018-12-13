module Api
  module V1
    class CommentSerializer < Api::V1::BaseSerializer
      attributes :body
      attribute :image, &:attachment
    end
  end
end
