class BusinessesController < ApplicationController
  before_action :set_google_client
  # GET /businesses
  # GET /businesses.json
  def index
  end

  def list
    @postcode = params[:postcode]
    @radius   = params[:radius].to_i
    redirect_to root_url and return unless @postcode.present?
    radius_in_metres = @radius * 1.60934 * 1000
    location   = Geokit::Geocoders::GoogleGeocoder.geocode(@postcode)
    @places    = @client.spots(location.lat, location.lng, radius: @radius*1.60934*1000, detail: true) #1000m
    respond_to do |format|
      format.html
    end
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
