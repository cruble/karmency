class MomentsController < ApplicationController

  def new
    @moment = Moment.new()
    @coin = Coin.find(params[:coin_id])
    @date_today = date_today
  end

  private

  def date_today
    Time.now.strftime('%D')
  end

end
