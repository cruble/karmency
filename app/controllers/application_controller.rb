class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def home
  end

  def login_status
    if current_user
      @login_status = {loginStatus: true}
    else
      @login_status = {loginStatus: false}
    end

    respond_to do |format|
      format.json {render json: @login_status}
    end
  end

end
