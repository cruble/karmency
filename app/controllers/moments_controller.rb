class MomentsController < ApplicationController

  def new
    @moment = Moment.new()
    @coin = Coin.find(params[:coin_id])
  end

end
