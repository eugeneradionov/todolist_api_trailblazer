class Api::V1::Project::Create < Trailblazer::Operation
  step :params_options!
  step Api::V1::Step::ParseParams.new
  step Model(Project, :new)
  step Policy::Pundit(ProjectPolicy, :create?)
  step Contract::Build(constant: Api::V1::Project::Contract::Create)
  step Contract::Validate()
  step Contract::Persist()

  def params_options!(options, current_user:, **)
    options[:params_fetch] = :project
    options[:params_permit] = :name
    options[:params_merge] = { user_id: current_user.id }
  end
end
