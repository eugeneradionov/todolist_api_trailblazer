class Api::V1::ProjectsController < Api::V1::ApplicationController
  extend Api::V1::ProjectsDoc

  SERIALIZER = Api::V1::ProjectSerializer

  index_doc
  def index
    run Api::V1::Project::Index do
      return render_model(200)
    end

    handle_errors
  end

  show_doc
  def show
    run Api::V1::Project::Show do
      return render_model(200)
    end

    handle_errors
  end

  create_doc
  def create
    run Api::V1::Project::Create do
      return render_model(201)
    end

    handle_errors
  end

  update_doc
  def update
    run Api::V1::Project::Update do
      return render_model(201)
    end

    handle_errors
  end

  destroy_doc
  def destroy
    run Api::V1::Project::Destroy do
      return render_model(204)
    end

    handle_errors
  end
end
