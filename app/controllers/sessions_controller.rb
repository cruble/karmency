class SessionsController < Devise::SessionsController

  after_action :set_csrf_headers, only: :create

  respond_to :json

  protected

  def set_csrf_headers
    if request.xhr?
      # Add the newly created csrf token to the page headers
      # These values are sent on 1 request only
      response.headers['X-CSRF-Token'] = "#{form_authenticity_token}"
      response.headers['X-CSRF-Param'] = "#{request_forgery_protection_token}"
    end
  end

end
