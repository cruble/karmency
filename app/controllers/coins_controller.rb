class CoinsController < ApplicationController

  def lookup

  end 

  def show
    if params[:code] 
      @coin = Coin.find_by(code: params[:code])
    else
      @coin = Coin.find_by(code: params[:id])
    end 
    
    @moments = @coin.moments
    respond_to do |format|
      format.json {render json: {result: true}}
      format.html {}
    end 

  end




end
