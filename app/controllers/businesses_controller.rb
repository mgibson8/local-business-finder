class BusinessesController < ApplicationController
  before_action :set_google_client
  before_action :set_types, only: [:index]
  # GET /businesses
  # GET /businesses.json
  def index
  end

  def list
    @postcode = params[:postcode]
    @radius   = params[:radius].to_i
    redirect_to root_url and return unless @postcode.present?
    @radius_in_metres = @radius * 1.60934 * 1000
    @location = Geokit::Geocoders::GoogleGeocoder.geocode(@postcode)
    @places   = @client.spots(@location.lat, @location.lng, radius: @radius*1.60934*1000, detail: true)


    respond_to do |format|
      format.js
    end
  end

  def download_csv
    lat    = params[:lat]
    lng    = params[:lng]
    radius = params[:rad]
    places = @client.spots(lat, lng, radius: radius, detail: true)

    businesses = Array.new
    businesses << ["Name", "Address", "Phone", "Type"]
    places.each do |place|
      businesses << [place.name, place.formatted_address, place.formatted_phone_number, place.types.map(&:humanize).join('/')]
    end

    respond_to do |format|
      format.html
      format.csv { send_data businesses.to_csv, filename: "companies-#{Date.today}.csv", type: "text/csv"}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions
    def set_google_client
      @client = GooglePlaces::Client.new("AIzaSyDlFqxHqgFzsbL-Pxh7TAxlwiPfyLzjMsY")
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def business_params
      params.require(:business).permit!
    end
    def set_types
      @types = ["accounting","airport","amusement_park","aquarium","art_gallery","atm","bakery","bank","bar","beauty_salon","bicycle_store","book_store","bowling_alley","bus_station","cafe","campground","car_dealer","car_rental","car_repair","car_wash","casino","cemetery","church","city_hall","clothing_store","convenience_store","courthouse","dentist","department_store","doctor","electrician","electronics_store","embassy","establishment","finance","fire_station","florist","food","funeral_home","furniture_store","gas_station","general_contractor","grocery_or_supermarket","gym","hair_care","hardware_store","health","hindu_temple","home_goods_store","hospital","insurance_agency","jewelry_store","laundry","lawyer","library","liquor_store","local_government_office","locksmith","lodging","meal_delivery","meal_takeaway","mosque","movie_rental","movie_theater","moving_company","museum","night_club","painter","park","parking","pet_store","pharmacy","physiotherapist","place_of_worship","plumber","police","post_office","real_estate_agency","restaurant","roofing_contractor","rv_park","school","shoe_store","shopping_mall","spa","stadium","storage","store","subway_station","synagogue","taxi_stand","train_station","transit_station","travel_agency","university","veterinary_care","zoo"]
    end
end
