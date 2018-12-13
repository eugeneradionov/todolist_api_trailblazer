class Api::V1::Task::Contract::Create < Reform::Form
  property :name
  property :project_id
  property :deadline
end
