class MomentsController < ApplicationController

  def new
    @moment = Moment.new()
    @date_today = date_today
  end

  private

  def date_today
    Time.now.strftime('%D')
  end

end
