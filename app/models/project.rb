class Project < ApplicationRecord
  include Rails.application.routes.url_helpers

  belongs_to :user

  has_many :tasks, -> { order(position: :asc) }, dependent: :destroy

  validates :name, presence: true, length: { maximum: 200 }, uniqueness: { scope: :user_id }

  def url
    api_v1_project_url(self)
  end
end
