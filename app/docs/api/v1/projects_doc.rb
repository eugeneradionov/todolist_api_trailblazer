module Api::V1::ProjectsDoc
  include Api::V1::BaseDoc

  def index_doc
    base_doc
    api :GET, '/projects', 'Returns all projects for current User'
  end

  def show_doc
    base_doc
    api :GET, '/projects/:id', 'Returns project, selected by id'
  end

  def create_doc
    base_doc
    api :POST, '/projects', 'Creates new project'
    param_group :project_params, ::Api::V1::ProjectsDoc
  end

  def update_doc
    base_doc
    api :PATCH, '/projects/:id', 'Updates project, selected by id'
    param_group :project_params, ::Api::V1::ProjectsDoc
    param :id, :number, required: true
  end

  def destroy_doc
    base_doc
    api :DELETE, '/projects/:id', 'Destroys project, selected by id, and all its tasks and comments'
    param :id, :number, required: true
  end

  def_param_group :project_params do
    param :data, Hash, action_aware: true, required: true do
      param :attributes, Hash, action_aware: true, required: true do
        param :name, String, required: true
      end
    end
  end
end
