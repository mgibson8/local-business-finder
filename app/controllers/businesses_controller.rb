class BusinessesController < ApplicationController
  before_action :set_google_client
  # GET /businesses
  # GET /businesses.json
  def index
  end

  def list
    @postcode = params[:postcode]
    location  = Geokit::Geocoders::GoogleGeocoder.geocode(@postcode)
    places    = @client.spots(53.5354934, -1.1757078, radius: 1000, detail: true) #1000m
  end

  private
    # Use callbacks to share common setup or constraints between actions
    def set_google_client
      @client = GooglePlaces::Client.new("AIzaSyDlFqxHqgFzsbL-Pxh7TAxlwiPfyLzjMsY")
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def business_params
      params.require(:business).permit(:postcode)
    end
end
