class Api::V1::Task::Destroy < Trailblazer::Operation
  step Model(Task, :find, :id)
  step Policy::Pundit(TaskPolicy, :destroy?)
  step :destroy!

  def destroy!(options, model:, **)
    model.destroy
    options[:model] = Task.none
  end
end
