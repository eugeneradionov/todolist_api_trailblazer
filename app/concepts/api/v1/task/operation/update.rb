class Api::V1::Task::Update < Trailblazer::Operation
  step Model(Task, :find, :id)
  step Policy::Pundit(TaskPolicy, :update?)
  step :params_options!
  step Api::V1::Step::ParseParams.new
  step Contract::Build(constant: Api::V1::Task::Contract::Update)
  step Contract::Validate()
  step Contract::Persist()

  def params_options!(options, **)
    options[:params_fetch] = :task
    options[:params_permit] = %i[name deadline completed move]
  end
end
