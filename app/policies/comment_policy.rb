class CommentPolicy < ApplicationPolicy
  def index?
    project_owner?
  end

  def create?
    project_owner?
  end

  def update?
    owner?
  end

  def destroy?
    task_owner?
  end

  private

  def owner?
    model.user_id == user.id
  end

  def project_owner?
    model.project.user_id == user.id
  end

  def task_owner?
    model.task.project.user_id == user.id
  end
end
