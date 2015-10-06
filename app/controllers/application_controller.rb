class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def home
    @coins = Coin.count
    @transactions = Moment.count
    @cities = Moment.select(:city).uniq.count
    @states = Moment.select(:state).uniq.count
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

  def after_sign_in_path_for(resource)
    request.env['omniauth.origin'] || root_path
  end

  def after_sign_out_path_for(resource_or_scope)
    request.referrer
  end

  def alert_link_text(alert)  
    alert.status? ? 'Off' : 'On'  
  end  

end
