class Api::V1::Project::Show < Trailblazer::Operation
  step Model(Project, :find, :id)
  step Policy::Pundit(ProjectPolicy, :show?)
end
