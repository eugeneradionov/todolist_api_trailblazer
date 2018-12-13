class Api::V1::Comment::Create < Trailblazer::Operation
  step :task_model!
  step Policy::Pundit(CommentPolicy, :create?)
  step :params_options!
  step Api::V1::Step::ParseParams.new
  step Model(Comment, :new)
  step Contract::Build(constant: Api::V1::Comment::Contract::Create)
  step Contract::Validate()
  step Contract::Persist()

  def task_model!(options, params:, **)
    options[:model] = Task.find(params[:task_id])
  end

  def params_options!(options, params:, **)
    options[:params_fetch] = :comment
    options[:params_permit] = %i[body attachment]
    options[:params_merge] = { task_id: params[:task_id] }
  end
end
