class Api::V1::Task::Position < Trailblazer::Operation
  step :task_model!
  step Policy::Pundit(TaskPolicy, :position?)
  step :params_options!
  step Api::V1::Step::ParseParams.new
  step Contract::Build(constant: Api::V1::Task::Contract::Position)
  step Contract::Validate()
  pass :change_position

  def task_model!(options, params:, **)
    options[:model] = Task.find(params[:id])
  end

  def params_options!(options, **)
    options[:params_fetch] = :task
    options[:params_permit] = %i[position]
  end

  def change_position(_options, model:, params:, **)
    position = params[:position].to_i
    model.insert_at(position)
  end
end
