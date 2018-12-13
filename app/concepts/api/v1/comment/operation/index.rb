class Api::V1::Comment::Index < Trailblazer::Operation
  step :task_model!
  step Policy::Pundit(CommentPolicy, :index?)
  step :comment_model!

  def task_model!(options, params:, **)
    options[:model] = Task.find(params[:task_id])
  end

  def comment_model!(options, model:, **)
    options[:model] = model.comments
  end
end
