class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  include DeviseTokenAuth::Concerns::SetUserByToken

  private

  def _run_options(options)
    options.merge!(current_user: current_user)
  end
end
