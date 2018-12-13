class Api::V1::CommentsController < Api::V1::ApplicationController
  extend Api::V1::CommentsDoc

  SERIALIZER = Api::V1::CommentSerializer

  index_doc
  def index
    run Api::V1::Comment::Index do
      return render_model(200)
    end

    handle_errors
  end

  create_doc
  def create
    run Api::V1::Comment::Create do
      return render_model(201)
    end

    handle_errors
  end

  def update
    run Api::V1::Comment::Update do
      return render_model(201)
    end

    handle_errors
  end

  destroy_doc
  def destroy
    run Api::V1::Comment::Destroy do
      return render_model(204)
    end

    handle_errors
  end
end
