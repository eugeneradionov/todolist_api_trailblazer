class Api::V1::Task::Show < Trailblazer::Operation
  step :task_model!
  step Policy::Pundit(TaskPolicy, :show?)

  def task_model!(options, params:, **)
    options[:model] = Task.includes(:comments).find(params[:id])
  end
end
