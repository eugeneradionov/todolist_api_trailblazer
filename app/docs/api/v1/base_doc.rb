module Api::V1::BaseDoc
  def self.included(base)
    base.extend Apipie::DSL::Concern
  end

  def base_doc
    formats [:json]
    api_version 'v1'
  end

  def forbidden_error
    error 403, "Forbidden | #{I18n.t('errors.access_denied')}"
  end

  def invalid_data_error
    error 422, 'Unprocessable entity | Invalid data'
  end

  def unprocessable_error(attribute, reason)
    default_types = %i[blank taken]
    reason = I18n.t("errors.messages.#{reason}") if default_types.include?(type)
    error 422, "Unprocessable entity | '#{attribute}' #{reason}"
  end

  def not_found_error(type)
    message = I18n.t('errors.not_found', object_class: type, id: '(:id)')
    error 404, "Not Found | #{message}"
  end
end
