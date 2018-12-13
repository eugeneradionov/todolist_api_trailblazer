class Api::V1::Task::Create < Trailblazer::Operation
  step :project_model!
  step Policy::Pundit(TaskPolicy, :create?)
  step :params_options!
  step Api::V1::Step::ParseParams.new
  step Model(Task, :new)
  step Contract::Build(constant: Api::V1::Task::Contract::Create)
  step Contract::Validate()
  step Contract::Persist()

  def project_model!(options, params:, **)
    options[:model] = Project.find(params[:project_id])
  end

  def params_options!(options, params:, **)
    options[:params_fetch] = :task
    options[:params_permit] = %i[name deadline completed]
    options[:params_merge] = { project_id: params[:project_id] }
  end
end
