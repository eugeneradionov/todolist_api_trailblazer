class Comment < ApplicationRecord
  belongs_to :task, counter_cache: true

  validates :body, length: { in: 1..256 }, presence: true

  # mount_base64_uploader :attachment, AttachmentUploader
end
