Apipie.configure do |config|
  config.app_name                = "TodolistApiTrailblazer"
  config.api_base_url            = "/api/v1"
  config.doc_base_url            = "/apipie"
  config.api_controllers_matcher = "#{Rails.root}/app/controllers/api/v1/**/*.rb"
  config.show_all_examples       = true
end
