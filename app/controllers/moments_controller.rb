class MomentsController < ApplicationController

  def new
    @moment = Moment.new()
    @coin = Coin.find(params[:coin_id])
  end

  def create
    binding.pry
    @moment = Moment.create(description: moment_params['description'], coin_id: params['coin_id'], date: params['date'])

    # this is where we left off. date issue. 

  end

  private

  def moment_params
    params.require(:moment).permit(:description, :state, :city, :date, :giver, :receiver)
  end

end
