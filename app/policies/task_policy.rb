class TaskPolicy < ApplicationPolicy
  def index?
    owner?
  end

  def show?
    project_owner?
  end

  def create?
    owner?
  end

  def update?
    project_owner?
  end

  def position?
    project_owner?
  end

  def complete?
    project_owner?
  end

  def destroy?
    project_owner?
  end

  private

  def owner?
    model.user_id == user.id
  end

  def project_owner?
    model.project.user_id = user.id
  end
end
