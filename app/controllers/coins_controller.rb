class CoinsController < ApplicationController

  def lookup
  end

  def new
    @coin = Coin.new()
  end

  def create
    @coin = Coin.new(coin_params)
    @coin.code = next_code(Coin.last.code)
    @coin.save
  end

  def show
    if params[:code]
      @coin = Coin.find_by(code: params[:code])
    else
      @coin = Coin.find_by(code: params[:id])
    end

    @moments = @coin.moments if @coin

    respond_to do |format|
      format.json {render json: {result: !!@coin}}
      format.html {}
    end

  end

  private

  def coin_params
    params.require(:coin).permit(:description, :state, :city)
  end

  def next_code(last_code)
    values = ("A".."Z").to_a + ("0".."9").to_a
    updated = false
    next_code = []
    last_code.split(//).reverse.each_with_index { |digit, index|
      if digit != values.last && updated == false
        next_code[index-1] = values.first unless index == 0
        next_code.unshift(values[values.index(digit) + 1])
        updated = true
      else
        next_code.unshift(digit)
      end
    }
    next_code.join
  end

end
