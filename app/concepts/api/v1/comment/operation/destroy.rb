class Api::V1::Comment::Destroy < Trailblazer::Operation
  step Model(Comment, :find, :id)
  step Policy::Pundit(CommentPolicy, :destroy?)
  step :destroy!

  def destroy!(options, model:, **)
    model.destroy
    options[:model] = Comment.none
  end
end
