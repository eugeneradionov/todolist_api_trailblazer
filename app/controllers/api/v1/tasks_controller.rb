class Api::V1::TasksController < Api::V1::ApplicationController
  extend Api::V1::TasksDoc

  SERIALIZER = Api::V1::Tasks::MainSerializer

  index_doc
  def index
    run Api::V1::Task::Index do
      return render_model(200)
    end

    handle_errors
  end

  show_doc
  def show
    run Api::V1::Task::Show do
      return render_model(200)
    end

    handle_errors
  end

  create_doc
  def create
    run Api::V1::Task::Create do
      return render_model(201)
    end

    handle_errors
  end

  update_doc
  def update
    run Api::V1::Task::Update do
      return render_model(201)
    end

    handle_errors
  end

  position_doc
  def position
    run Api::V1::Task::Position do
      return render_model(201, Api::V1::Tasks::PositionSerializer)
    end

    handle_errors
  end

  complete_doc
  def complete
    run Api::V1::Task::Complete do
      return render_model(201)
    end

    handle_errors
  end

  destroy_doc
  def destroy
    run Api::V1::Task::Destroy do
      return render_model(204)
    end

    handle_errors
  end
end
