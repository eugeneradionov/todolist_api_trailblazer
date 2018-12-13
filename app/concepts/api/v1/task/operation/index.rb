class Api::V1::Task::Index < Trailblazer::Operation
  step :project_model!
  step Policy::Pundit(TaskPolicy, :index?)
  step :task_model!

  def project_model!(options, params:, **)
    options[:model] = Project.find(params[:project_id])
  end

  def task_model!(options, model:, **)
    options[:model] = model.tasks.includes(:comments)
  end
end
