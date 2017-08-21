class BusinessesController < ApplicationController
  # GET /businesses
  # GET /businesses.json
  def index
    @client = GooglePlaces::Client.new("AIzaSyDlFqxHqgFzsbL-Pxh7TAxlwiPfyLzjMsY")
    @places = @client.spots(53.5354934, -1.1757078, :radius => 1000) #1000m
  end

  def list
    binding.pry
  end

  private
    # Use callbacks to share common setup or constraints between actions
    # Never trust parameters from the scary internet, only allow the white list through.
    def business_params
      params.require(:business).permit(:name)
    end
end
