class Api::V1::Project::Update < Trailblazer::Operation
  step Model(Project, :find, :id)
  step Policy::Pundit(ProjectPolicy, :update?)
  step :params_options!
  step Api::V1::Step::ParseParams.new
  step Contract::Build(constant: Api::V1::Project::Contract::Update)
  step Contract::Validate()
  step Contract::Persist()

  def params_options!(options, **)
    options[:params_fetch] = :project
    options[:params_permit] = :name
  end
end
