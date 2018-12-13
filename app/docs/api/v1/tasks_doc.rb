module Api::V1::TasksDoc
  include Api::V1::BaseDoc

  def index_doc
    base_doc
    api :GET, '/projects/:project_id/tasks', 'Returns all tasks'
  end

  def show_doc
    base_doc
    api :GET, '/projects/:project_id/tasks/:id', 'Returns task by id'
  end

  def create_doc
    base_doc
    api :POST, '/projects/:project_id/tasks', 'Creates new task'
    param_group :task_params, ::Api::V1::TasksDoc
  end

  def update_doc
    base_doc
    api :PUT, '/projects/:project_id/tasks/:id', 'Updates task, selected by id'
    param_group :task_params, ::Api::V1::TasksDoc
  end

  def position_doc
    base_doc
    api :PUT, '/tasks/:task_id/position', 'Updates task position'
    param_group :task_position_params, ::Api::V1::TasksDoc
  end

  def complete_doc
    base_doc
    api :PUT, '/tasks/:task_id', 'Completes task'
  end

  def destroy_doc
    base_doc
    api :DELETE, '/projects/:project_id/tasks/:id', 'Destroys task, selected by id'
  end

  def_param_group :task_params do
    param :data, Hash, action_aware: true, required: true do
      param :attributes, Hash, action_aware: true, required: true do
        param :name, String, required: true
      end
    end
  end

  def_param_group :task_position_params do
    param :data, Hash, action_aware: true, required: true do
      param :attributes, Hash, action_aware: true, required: true do
        param :position, :number, required: true
      end
    end
  end
end
