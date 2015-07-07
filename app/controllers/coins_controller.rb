class CoinsController < ApplicationController

  def show
    @coin = Coin.find(params[:id])
    @moments = @coin.moments
  end

end
