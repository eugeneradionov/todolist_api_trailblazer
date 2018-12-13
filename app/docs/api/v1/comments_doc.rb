module Api::V1::CommentsDoc
  include Api::V1::BaseDoc

  def index_doc
    base_doc
    api :GET, '/projects/:project_id/tasks/:task_id/comments', 'Returns all comments'
  end

  def create_doc
    base_doc
    api :POST, '/projects/:project_id/tasks/:task_id/comments', 'Creates new comment'
    param_group :comment_params, ::Api::V1::CommentsDoc
  end

  def destroy_doc
    base_doc
    api :DELETE, '/projects/:project_id/comments/:id', 'Destroys comment, selected by id'
    param :id, :number, required: true
  end

  def_param_group :comment_params do
    param :data, Hash, action_aware: true, required: true do
      param :attributes, Hash, action_aware: true, required: true do
        param :body, String, required: true
        param :attachment, String, required: false, desc: 'Image'
      end
    end
  end
end
