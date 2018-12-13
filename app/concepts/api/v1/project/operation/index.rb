class Api::V1::Project::Index < Trailblazer::Operation
  step :model!
  step Policy::Pundit(ProjectPolicy, :index?)

  def model!(options, current_user:, **)
    options[:model] = current_user.projects.includes(:tasks)
  end
end
