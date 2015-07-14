class LocationsController < ApplicationController

  def lookup

    # lookup location based on lat and long
    @result = Geocoder.search(params[:lat] + ","+ params[:lng]).first
    @location = {state: @result.state, city: @result.city}

    respond_to do |format|
      format.json {render json: @location}
    end

  end

  def validate
    if params[:state] == "Non-U.S."
      result_type = "Non-U.S."
    else
      result_type = Geocoder.search(params[:city] + ", " + params[:state])[0].data["types"][0]
    end

    respond_to do |format|
      format.json {render json: {isCity: is_city?(result_type)}}
    end
  end

  private

  def is_city?(result_type)
    case result_type
    when "Non-U.S."
      true
    when "locality"
      true
    when "sublocality"
      true
    when "sublocality_level_1"
      true
    when "administrative_area_level_3"
      true
    when "administrative_area_level_2"
      true
    else
      false
    end
  end

  # TODO:
  # 1. Determine list of types that we consider a city
  # 2. Order them
  # 3. Write logic to retrieve first available from user's geo data

end
