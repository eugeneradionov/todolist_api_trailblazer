class Api::V1::Project::Destroy < Trailblazer::Operation
  step Model(Project, :find, :id)
  step Policy::Pundit(ProjectPolicy, :destroy?)
  step :destroy!

  def destroy!(options, model:, **)
    model.destroy
    options[:model] = Project.none
  end
end
