class LocationsController < ApplicationController

  def lookup

    # lookup location based on lat and long
    @result = Geocoder.search(params[:lat] + ","+ params[:lng]).first
    @location = {location: ["neighborhood","city","state"].map do |area_level|
      @result.send(area_level)
    end.compact.join(", ")}

    respond_to do |format|
      format.json {render json: @location}
    end 

  end

end