class RevertController < ApplicationController
  def index
    @link = Link.new
  end

  def create
    short_link = full_link = link_params[:short_link]
    while true
      break if get_location(full_link) == 0
      if get_location(full_link) == -1
        flash[:alert] = "`#{short_link}` is not a  link"
        redirect_to revert_index_path and return
      else
        full_link = get_location(full_link)
      end
    end

    if short_link == full_link
      flash[:alert] = "`#{short_link}` is not a short_link link"
      redirect_to revert_index_path and return
    else
      domain = Addressable::URI.parse(full_link).host
      @link = current_user.links.build({ full_link: full_link, short_link: short_link, domain: domain, link_type: 1 })
      unless @link.save
        flash[:alert] = "ERROR"
        redirect_to revert_index_path and return
      end
    end

    respond_to do |format|
      format.html
      format.js
    end
  end

  private

  def get_location(link)
    begin
      headers = insensitive_hash(HTTP.get(link).headers)
      return 0 if headers['location'].nil? # is link but not has location
      return headers['location'] # get a location
    rescue HTTP::Request::UnsupportedSchemeError # not a link
      return -1
    end
  end

  def link_params
    params.require(:link).permit(:short_link)
  end

  def insensitive_hash(h)
    h.each do |k,v|
      k = k.downcase
    end
  end
end
