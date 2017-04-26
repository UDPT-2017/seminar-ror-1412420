class ShortenController < ApplicationController
  def index
    if @link = Link.find_by!(short_link: params[:id])
      tracking
      @link.hits.create({ ip_address: @ip, location: @location })
      redirect_to @link.full_link and return
    end
    redirect_to root_path
  end

  def tracking
    @geocode = request.location
    @ip = @geocode.ip
    @location = @geocode.country
  end
end
