class MomentsController < ApplicationController

  def new
    @moment = Moment.new()
    @coin = Coin.find(params[:coin_id])
  end

  def create
    binding.pry
  end

  private

  def moment_params
    #
  end

end
