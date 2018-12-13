class Api::V1::Comment::Contract::Create < Reform::Form
  property :body
  property :task_id
  property :attachment
end
