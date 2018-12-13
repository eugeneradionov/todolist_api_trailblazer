class Api::V1::Task::Complete < Trailblazer::Operation
  step :task_model!
  step :complete_task

  def task_model!(options, params:, **)
    options[:model] = Task.find(params[:id])
  end

  def complete_task(_options, model:, **)
    model.change_completion!
  end
end
